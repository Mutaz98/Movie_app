import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent {}

class AuthCreateSession extends AuthEvent {
  final String requestToken;

  AuthCreateSession({required this.requestToken});

  @override
  List<Object?> get props => [requestToken];
}

class AuthLogout extends AuthEvent {}
