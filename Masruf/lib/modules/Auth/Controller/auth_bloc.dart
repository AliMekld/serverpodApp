import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Home/home_screen.dart';
import '../Model/Repository/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository _repo;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthBloc(this._repo) : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ToggleAuthModeEvent>(_onToggleAuthMode);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibilityEvent>(_onToggleConfirmPasswordVisibility);
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await _repo.login(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (l) => emit(state.copyWith(isLoading: false, errorMessage: l.toString())),
        (r) {
          emit(state.copyWith(isLoading: false));
          if (event.context.mounted) {
            event.context.goNamed(HomeScreen.routerName);
          }
        },
      );
    }
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await _repo.register(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (l) => emit(state.copyWith(isLoading: false, errorMessage: l.toString())),
        (r) {
           emit(state.copyWith(isLoading: false));
        },
      );
    }
  }

  void _onToggleAuthMode(
    ToggleAuthModeEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isLogin: !state.isLogin));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }
}
