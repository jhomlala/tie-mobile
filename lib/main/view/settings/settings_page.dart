import 'package:flutter/material.dart';
import 'package:tie_mobile/auth/bloc/auth_bloc.dart';
import 'package:ui/ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthBloc get authBloc => context.bloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            authBloc.add(const AuthEvent.signOut());
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
