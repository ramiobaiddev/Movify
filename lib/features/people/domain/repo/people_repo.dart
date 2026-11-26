import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

abstract interface class PeopleRepo {
  Future<Either<Failure, PageResult<PersonItem>>> popular({int page = 1});

  Future<Either<Failure, PersonDetails>> details(int id);
}
