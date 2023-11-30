import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tie_mobile/main/bloc/main_bloc.dart';
import 'package:tie_mobile/main/view/main_page.dart';


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
          )
        ],
        child: const MainPage(),
      ),
    );
  }
}
