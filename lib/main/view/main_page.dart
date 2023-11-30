import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tie_mobile/common/extensions/context_ext.dart';
import 'package:tie_mobile/main/bloc/main_bloc.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      builder: (BuildContext context, MainState state) {
        return Scaffold(
          bottomNavigationBar: _MainPageBottomNavigationBar(),
          body: Container(),
        );
      },
      listener: (BuildContext context, MainState state) {},
    );
  }
}

class _MainPageBottomNavigationBar extends StatelessWidget {
  const _MainPageBottomNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    final mainBloc = context.bloc<MainBloc>();

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: mainBloc.state.pageIndex,
        onTap: (index) {
          print("Set index = " + index.toString());
          mainBloc.add(MainEvent.setPage(index));
        },
        items: [
          _buildItem(Icons.home, 'Home'),
          _buildItem(Icons.book, 'Materials'),
          _buildItem(Icons.settings, 'Settings'),
        ],);
  }

  BottomNavigationBarItem _buildItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
