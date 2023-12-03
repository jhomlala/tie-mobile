import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class MaterialsDataSource{
  Future<Either<TieError, List<TieMaterial>>> getMaterials();
}