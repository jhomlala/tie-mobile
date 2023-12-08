import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tie_mobile/app/tie_app.dart';

Future<void> mainCommon(Flavor flavor) async {
  setup();
  runApp(const TieApp());
}

void setup() {
  final getIt = GetIt.instance;
  final localMaterialsDataSource = LocalMaterialsDataSource();
  final remoteMaterialsDataSource = RemoteMaterialsDataSource();
  getIt.registerSingleton<MaterialsRepository>(
    MaterialsRepository(
      localDataSource: localMaterialsDataSource,
      remoteDataSource: remoteMaterialsDataSource,
    ),
  );
}
