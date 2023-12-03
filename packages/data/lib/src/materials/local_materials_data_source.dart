import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class LocalMaterialsDataSource extends MaterialsDataSource {
  @override
  Future<Either<TieError, List<TieMaterial>>> getMaterials() async {
    return const Right(
      [
        TieMaterial(
          id: '1',
          name: 'Hamster 1',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        TieMaterial(
          id: '2',
          name: 'Hamster 2',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        TieMaterial(
          id: '3',
          name: 'Hamster 3',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        TieMaterial(
          id: '1',
          name: 'Hamster 4',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        TieMaterial(
          id: '1',
          name: 'Hamster 5',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
      ],
    );
  }
}
