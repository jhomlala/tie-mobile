import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tie_mobile/auth/view/auth_page.dart';
import 'package:tie_mobile/main/view/main/main_page.dart';
import 'package:tie_mobile/material/view/material_page.dart';

enum Routes {
  auth('/'),
  home('/home'),
  material('/material');

  const Routes(this.path);

  final String path;
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.auth.path,
      name: Routes.auth.path,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),

    GoRoute(
      path: Routes.home.path,
      name: Routes.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: Routes.material.path,
      name: Routes.material.path,
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra == null) {
          throw TieNavigationError('Material data is empty');
        }

        final tieMaterial = state.extra! as TieMaterial;
        return TieMaterialPage(material: tieMaterial);
      },
    ),
  ],
);
