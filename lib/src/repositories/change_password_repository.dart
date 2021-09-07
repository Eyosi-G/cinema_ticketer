import '../data_providers/data_provider.dart';

class ChangePasswordRepository {
  final ChangePasswordDataProvider _changePasswordDataProvider;
  ChangePasswordRepository(this._changePasswordDataProvider);

  Future changePassword(String oldPassword, String newPassword) async {
    return await _changePasswordDataProvider.changePassword(
        oldPassword, newPassword);
  }
}
