import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tie_mobile/main/bloc/main/main_bloc.dart';
import 'package:tie_mobile/main/bloc/materials/materials_bloc.dart';
import 'package:tie_mobile/main/view/main/main_page.dart';

class TieApp extends StatefulWidget {
  const TieApp({super.key});

  @override
  State<TieApp> createState() => _TieAppState();
}

class _TieAppState extends State<TieApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
            create: (context) {
              return MainBloc();
            },
          ),
          BlocProvider<MaterialsBloc>(
            create: (context) {
              return MaterialsBloc(
                materialsRepository: GetIt.I.get(),
              );
            },
          )
        ],
        child: const MainPage(),
      ),
    );
  }
}
