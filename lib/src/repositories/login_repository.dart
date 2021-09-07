import '../data_providers/data_provider.dart';

class LoginRepository {
  final LoginDataProvider _loginDataProvider;
  LoginRepository(this._loginDataProvider);

  Future<String> login(username, password) {
    return this._loginDataProvider.login(username, password);
  }
}
