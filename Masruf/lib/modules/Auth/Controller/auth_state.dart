part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool isLogin;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.isLogin = true,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        isLogin,
        isPasswordVisible,
        isConfirmPasswordVisible,
      ];

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLogin,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) =>
      AuthState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isLogin: isLogin ?? this.isLogin,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      );
}
