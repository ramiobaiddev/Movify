import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/cubit/row_kind_cubit.dart';

import '../../helpers/hydrated_storage.dart';

void main() {
  setUpAll(initHydratedStorage);

  test('defaults to movies and remembers the choice per row', () async {
    final a = RowKindCubit(rowId: 'for_you');
    expect(a.state, ContentType.movies);
    a.select(ContentType.series);
    await a.close();

    expect(RowKindCubit(rowId: 'for_you').state, ContentType.series);
    expect(RowKindCubit(rowId: 'all_time_favorites').state, ContentType.movies);
  });

  test('ignores kinds that are not movies or series', () {
    final c = RowKindCubit(rowId: 'x')..select(ContentType.episodes);
    expect(c.state, ContentType.movies);
  });
}
