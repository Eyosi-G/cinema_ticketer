import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';
import '../../repositories/repositories.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordRepository _changePasswordRepository;
  ChangePasswordBloc(this._changePasswordRepository)
      : super(ChangePasswordInitialState());

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    try {
      yield ChangePasswordStarted();

      await _changePasswordRepository.changePassword(
          event.oldPassword, event.newPassword);
      yield ChangePasswordSuccess();
    } catch (e) {
      print(e);
      yield ChangePasswordFailure("Change Password Failed!");
    }
  }
}
