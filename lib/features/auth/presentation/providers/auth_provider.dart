import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

// Es una clase que extiende StateNotifier<AuthState>,
//lo que significa que es capaz de manejar y notificar cambios en
//el estado de tipo AuthState.
class AuthNotifier extends StateNotifier<AuthState> {
  // atributo authRepository que almacena una instancia de AuthRepository
  // para interactuar con la capa de datos.
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      print('usuario ===>>> $user');
      _setLoggedUser(user);
    } on WrongCredentials {
      logoutUser('Credenciales incorrectas');
    } catch (e) {
      logoutUser('Error no controlado');
    }
  }

  void _setLoggedUser(User user) {
    //TODO: Necesito guardar el token en dispositivo

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logoutUser(String errorMessage) async {
    //TODO:  limpiar token

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
