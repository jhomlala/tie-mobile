import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tie_mobile/app/router.dart';
import 'package:tie_mobile/auth/bloc/auth_bloc.dart';
import 'package:ui/ui.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthBloc get authBloc => context.bloc();
  bool initialised = false;

  @override
  void initState() {
    super.initState();
    if (!initialised) {
      initialised = true;
      authBloc.add(const AuthInitialise());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state.isAuthenticated) {
          context.replace(Routes.home.path);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (state.isLoading) {
                return const Center(child: LoadingIndicator());
              } else {
                if (!state.isAuthenticated) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            authBloc.add(
                              const AuthEvent.register(
                                email: '',
                                password: '',
                              ),
                            );
                          },
                          child: const Text('Register'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            authBloc.add(
                              const AuthEvent.authenticate(
                                email: '',
                                password: '',
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                        if (state.authFailed)
                          const Text(
                            'Auth failed.',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
