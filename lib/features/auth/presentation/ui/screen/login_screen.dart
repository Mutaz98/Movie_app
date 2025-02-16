import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_event.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_state.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthRequestTokenGenerated) {
            // Launch URL to authenticate the user

            return Center(
              child: ElevatedButton(
                onPressed: () => context
                    .read<AuthBloc>()
                    .add(AuthCreateSession(requestToken: state.requestToken)),
                child: const Text("Authenticate User"),
              ),
            );
          } else if (state is AuthAuthenticated) {
            return Center(
                child: Text("Authenticated! Session ID: ${state.sessionId}"));
          } else if (state is AuthError) {
            return Center(
                child: Text("Authenticated! Session ID: ${state.message}"));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(AuthLogin()),
              child: Text("Login"),
            ),
          );
        },
      ),
    );
  }
}
