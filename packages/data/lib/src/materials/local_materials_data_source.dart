import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class LocalMaterialsDataSource extends MaterialsDataSource {
  @override
  Future<Either<TieError, List<Material>>> getMaterials() async {
    return const Right(
      [
        Material(id: '1', name: 'Test', type: 'hamster'),
      ],
    );
  }
}
