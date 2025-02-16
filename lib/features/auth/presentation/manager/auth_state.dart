abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String sessionId;
  AuthAuthenticated(this.sessionId);
}

class AuthRequestTokenGenerated extends AuthState {
  final String requestToken;
  AuthRequestTokenGenerated(this.requestToken);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
