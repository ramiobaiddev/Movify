import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/paged_state.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';

PageResult<int> _page(int page, {int totalPages = 3}) => PageResult<int>(
  page: page,
  totalPages: totalPages,
  totalResults: totalPages * 2,
  results: [page * 10, page * 10 + 1],
);

Either<Failure, PageResult<int>> _ok(int page, {int totalPages = 3}) =>
    Right(_page(page, totalPages: totalPages));

Either<Failure, PageResult<int>> _fail([String message = 'boom']) =>
    Left(ServerFailure(errorMessage: message));

void main() {
  group('PagedCubit', () {
    test('load: emits loading then success with the first page', () async {
      final cubit = PagedCubit<int>((page) async => _ok(page));
      final states = <PagedState<int>>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(states.map((s) => s.status), [
        PagedStatus.loading,
        PagedStatus.success,
      ]);
      expect(cubit.state.items, [10, 11]);
      expect(cubit.state.page, 1);
      expect(cubit.state.totalPages, 3);
      await sub.cancel();
      await cubit.close();
    });

    test('load: second call does not fetch again', () async {
      var calls = 0;
      final cubit = PagedCubit<int>((page) async {
        calls++;
        return _ok(page);
      });

      await cubit.load();
      await cubit.load();

      expect(calls, 1);
      await cubit.close();
    });

    test('load: failure sets failure status and error message', () async {
      final cubit = PagedCubit<int>((page) async => _fail('no internet'));

      await cubit.load();

      expect(cubit.state.status, PagedStatus.failure);
      expect(cubit.state.error, 'no internet');
      expect(cubit.state.isFirstError, isTrue);
      await cubit.close();
    });

    test('refresh after a failure recovers', () async {
      var fail = true;
      final cubit = PagedCubit<int>(
        (page) async => fail ? _fail() : _ok(page),
      );

      await cubit.load();
      expect(cubit.state.isFirstError, isTrue);

      fail = false;
      await cubit.refresh();

      expect(cubit.state.status, PagedStatus.success);
      expect(cubit.state.error, isNull);
      expect(cubit.state.items, [10, 11]);
      await cubit.close();
    });

    test('loadMore: appends the next page', () async {
      final cubit = PagedCubit<int>((page) async => _ok(page));
      await cubit.load();

      await cubit.loadMore();

      expect(cubit.state.items, [10, 11, 20, 21]);
      expect(cubit.state.page, 2);
      expect(cubit.state.isLoadingMore, isFalse);
      await cubit.close();
    });

    test('loadMore: does nothing on the last page', () async {
      var calls = 0;
      final cubit = PagedCubit<int>((page) async {
        calls++;
        return _ok(page, totalPages: 1);
      });
      await cubit.load();

      await cubit.loadMore();

      expect(calls, 1);
      expect(cubit.state.canLoadMore, isFalse);
      await cubit.close();
    });

    test('loadMore: concurrent calls fetch only one page', () async {
      final gate = Completer<void>();
      var calls = 0;
      final cubit = PagedCubit<int>((page) async {
        calls++;
        if (page == 2) await gate.future;
        return _ok(page);
      });
      await cubit.load();

      final first = cubit.loadMore();
      final second = cubit.loadMore();
      gate.complete();
      await Future.wait([first, second]);

      expect(calls, 2); // page 1 + page 2, not page 3
      expect(cubit.state.page, 2);
      expect(cubit.state.items, [10, 11, 20, 21]);
      await cubit.close();
    });

    test('loadMore failure keeps items and is not retried by scrolling', () async {
      var calls = 0;
      final cubit = PagedCubit<int>((page) async {
        calls++;
        return page == 2 ? _fail('page 2 failed') : _ok(page);
      });
      await cubit.load();

      await cubit.loadMore();
      await cubit.loadMore(); // scroll fires again: must be ignored

      expect(calls, 2);
      expect(cubit.state.items, [10, 11]);
      expect(cubit.state.hasLoadMoreError, isTrue);
      expect(cubit.state.error, 'page 2 failed');
      await cubit.close();
    });

    test('retryLoadMore fetches the failed page again', () async {
      var failPage2 = true;
      final cubit = PagedCubit<int>(
        (page) async => page == 2 && failPage2 ? _fail() : _ok(page),
      );
      await cubit.load();
      await cubit.loadMore();
      expect(cubit.state.hasLoadMoreError, isTrue);

      failPage2 = false;
      await cubit.retryLoadMore();

      expect(cubit.state.items, [10, 11, 20, 21]);
      expect(cubit.state.error, isNull);
      await cubit.close();
    });

    test('a stale loadMore response is dropped after refresh', () async {
      final gate = Completer<void>();
      var firstPageCalls = 0;
      final cubit = PagedCubit<int>((page) async {
        if (page == 1) {
          firstPageCalls++;
          return Right(
            PageResult<int>(
              page: 1,
              totalPages: 3,
              totalResults: 6,
              results: [firstPageCalls * 100],
            ),
          );
        }
        await gate.future; // page 2 is slow
        return _ok(page);
      });
      await cubit.load(); // items: [100]

      final slowMore = cubit.loadMore();
      await cubit.refresh(); // items: [200]; invalidates the slow request
      gate.complete();
      await slowMore;

      expect(cubit.state.items, [200]);
      expect(cubit.state.page, 1);
      expect(cubit.state.isLoadingMore, isFalse);
      await cubit.close();
    });

    test('empty first page is reported as empty, not an error', () async {
      final cubit = PagedCubit<int>(
        (page) async => const Right(
          PageResult<int>(page: 1, totalPages: 1, totalResults: 0, results: []),
        ),
      );

      await cubit.load();

      expect(cubit.state.isEmpty, isTrue);
      expect(cubit.state.isFirstError, isFalse);
      await cubit.close();
    });

    test('a response arriving after close is ignored', () async {
      final gate = Completer<void>();
      final cubit = PagedCubit<int>((page) async {
        await gate.future;
        return _ok(page);
      });

      final loading = cubit.load();
      await cubit.close();
      gate.complete();

      await expectLater(loading, completes);
    });
  });
}
