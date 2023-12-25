import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class MaterialsRepository {
  MaterialsRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final MaterialsDataSource localDataSource;
  final MaterialsDataSource remoteDataSource;

  Future<Either<TieError, List<TieMaterial>>> getMaterials() async {
    await remoteDataSource.getMaterials();
    final localMaterials = await localDataSource.getMaterials();

    return localMaterials;
  }
}
