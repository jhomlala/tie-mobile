import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class RemoteMaterialsDataSource extends MaterialsDataSource {
  @override
  Future<Either<TieError, List<TieMaterial>>> getMaterials() async {
    final data = await getFirestore().collection('materials').get();
    return const Right([]);
  }

  FirebaseFirestore getFirestore() {
    return FirebaseFirestore.instance;
  }
}
