
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/error/tie_error.dart';
class RemoteMaterialsDataSource extends MaterialsDataSource{
  @override
  Future<Either<TieError, List<TieMaterial>>> getMaterials() {
    // TODO: implement getMaterials
    throw UnimplementedError();
  }

}