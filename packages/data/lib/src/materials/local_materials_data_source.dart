import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';


class LocalMaterialsDataSource extends MaterialsDataSource {
  @override
  Future<Either<TieError, List<TieMaterial>>> getMaterials() async {
    return Right(
      [
        TieMaterial(
          id: '1',
          name: 'Hamster 1',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: jsonEncode(_getHamsterMaterial().toJson())
        ),
        const TieMaterial(
          id: '2',
          name: 'Hamster 2',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        const TieMaterial(
          id: '3',
          name: 'Hamster 3',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        const TieMaterial(
          id: '1',
          name: 'Hamster 4',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
        const TieMaterial(
          id: '1',
          name: 'Hamster 5',
          type: 'hamster',
          image: 'https://cdn-icons-png.flaticon.com/512/6807/6807896.png',
          config: '{}',
        ),
      ],
    );
  }

  HamsterMaterial _getHamsterMaterial() {
    final tiles = <HamsterMaterialTile>[];
    for (var horizontalIndex = 1; horizontalIndex < 6; horizontalIndex++) {
      for (var  verticalIndex = 1; verticalIndex < 6; verticalIndex++) {
        tiles.add(
          HamsterMaterialTile(
            boardX: horizontalIndex,
            boardY: verticalIndex,
            imageUrl:
                'https://easydrawingguides.com/wp-content/uploads/2022/07/cute-cartoon-cat-11.png',
            answers: [
              const HamsterMaterialAnswer(
                name: 'Cat',
                isCorrect: true,
              ),
              const HamsterMaterialAnswer(
                name: 'Dog',
                isCorrect: false,
              ),
              const HamsterMaterialAnswer(
                name: 'Mouse',
                isCorrect: false,
              )
            ],
          ),
        );
      }
    }

    Log.info("Created tiles! " + tiles.length.toString());

    return HamsterMaterial(tiles: tiles);
  }
}
