import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/domain/use_cases/get_person_details_use_case.dart';
import 'package:movify/features/people/presentation/cubits/person_details_cubit.dart';
import 'package:movify/features/people/presentation/cubits/person_details_state.dart';

class _GetDetails extends Mock implements GetPersonDetailsUseCase {}

const _details = PersonDetails(
  id: 1,
  name: 'Jane Cooper',
  profilePath: null,
  biography: '',
  birthday: null,
  deathday: null,
  placeOfBirth: '',
  knownForDepartment: 'Acting',
  movies: [],
  series: [],
);

void main() {
  late _GetDetails getDetails;
  late PersonDetailsCubit cubit;

  setUp(() {
    getDetails = _GetDetails();
    cubit = PersonDetailsCubit(getDetails);
  });

  tearDown(() => cubit.close());

  test('starts loading', () {
    expect(cubit.state, isA<PersonDetailsLoading>());
  });

  test('loads the details', () async {
    when(() => getDetails(1)).thenAnswer((_) async => const Right(_details));

    await cubit.load(1);

    expect(cubit.state, const PersonDetailsLoaded(_details));
  });

  test('a failure becomes an error that load can retry', () async {
    when(
      () => getDetails(1),
    ).thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'boom')));

    await cubit.load(1);
    expect(cubit.state, const PersonDetailsError('boom'));

    when(() => getDetails(1)).thenAnswer((_) async => const Right(_details));
    await cubit.load(1);
    expect(cubit.state, isA<PersonDetailsLoaded>());
  });
}
