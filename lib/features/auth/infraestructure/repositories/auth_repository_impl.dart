import 'package:teslo_shop/features/auth/domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl({required this.datasource});

  // AuthRepositoryImpl(AuthDataSource? dataSource)
  //     : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
