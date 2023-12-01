import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class MaterialsRepository {
  MaterialsRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final MaterialsDataSource localDataSource;
  final MaterialsDataSource remoteDataSource;

  @override
  Future<Either<TieError, List<Material>>> getMaterials() async {
    return localDataSource.getMaterials();
  }
}
