import 'package:bloc/bloc.dart';
import 'package:movie_app/features/auth/domain/use_cases/create_session_use_case.dart';
import 'package:movie_app/features/auth/domain/use_cases/get_request_token_use_case.dart';
import 'package:movie_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_event.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetRequestTokenUseCase getRequestToken;
  final CreateSession createSession;
  final LogOutUseCase logout;

  AuthBloc({
    required this.getRequestToken,
    required this.createSession,
    required this.logout,
  }) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final requestToken = await getRequestToken();
        emit(AuthRequestTokenGenerated(requestToken));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthCreateSession>((event, emit) async {
      emit(AuthLoading());
      try {
        final session = await createSession(event.requestToken);
        emit(AuthAuthenticated(session.sessionId));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      await logout();
      emit(AuthInitial());
    });
  }
}
