import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tie_mobile/app/tie_app.dart';
import 'package:tie_mobile/firebase_options.dart';

Future<void> mainCommon(Flavor flavor) async {
  await setup();
  runApp(const TieApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  final localMaterialsDataSource = LocalMaterialsDataSource();
  final remoteMaterialsDataSource = RemoteMaterialsDataSource();

  getIt.registerSingleton<MaterialsRepository>(
    MaterialsRepository(
      localDataSource: localMaterialsDataSource,
      remoteDataSource: remoteMaterialsDataSource,
    ),
  );

  final remoteAuthDataSource = RemoteAuthDataSource();

  getIt.registerSingleton<AuthRepository>(
    AuthRepository(
      remoteAuthDataSource: remoteAuthDataSource,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
