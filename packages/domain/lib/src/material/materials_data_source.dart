import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

// ignore: one_member_abstracts
abstract class MaterialsDataSource {
  Future<Either<TieError, List<TieMaterial>>> getMaterials();
}
