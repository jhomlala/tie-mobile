import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tie_mobile/app/router.dart';
import 'package:tie_mobile/auth/bloc/auth_bloc.dart';
import 'package:tie_mobile/main/bloc/main/main_bloc.dart';
import 'package:tie_mobile/main/view/materials/materials_page.dart';
import 'package:tie_mobile/main/view/settings/settings_page.dart';
import 'package:ui/ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (!state.isAuthenticated){
          context.replace(Routes.auth.path);
        }
      },
      child: BlocConsumer<MainBloc, MainState>(
        builder: (BuildContext context, MainState state) {
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: const _MainPageBottomNavigationBar(),
            body: IndexedStack(
              index: state.pageIndex,
              children: const [Text('Home'), MaterialsPage(), SettingsPage()],
            ),
          );
        },
        listener: (BuildContext context, MainState state) {},
      ),
    );
  }
}

class _MainPageBottomNavigationBar extends StatelessWidget {
  const _MainPageBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.bloc<MainBloc>();

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: mainBloc.state.pageIndex,
      onTap: (index) {
        mainBloc.add(MainEvent.setPage(index));
      },
      items: [
        _buildItem(Icons.home, 'Home'),
        _buildItem(Icons.book, 'Materials'),
        _buildItem(Icons.settings, 'Settings'),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
