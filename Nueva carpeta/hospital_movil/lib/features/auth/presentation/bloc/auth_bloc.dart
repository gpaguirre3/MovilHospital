import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        username: event.username,
        password: event.password,
      ),
    );

    if (result is Success) {
      final session = (result as Success).data;
      emit(AuthSuccess(
        user: session.user,
        token: session.token,
        message: session.message,
      ));
    } else if (result is Error) {
      final failure = (result as Error).failure;
      emit(AuthFailureState(failure.message));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await logoutUseCase(NoParams());
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getCurrentUserUseCase(NoParams());
    if (result is Success) {
      final user = (result as Success).data;
      if (user != null) {
        emit(AuthSuccess(user: user, token: ''));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }
}
