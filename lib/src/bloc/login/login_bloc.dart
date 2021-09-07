import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/login_repository.dart';
import './login.dart';
import '../../config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginRepository _loginRepository;
  LoginBloc(this._loginRepository,
      [LoginStates initialState = LoginStates.INIT])
      : super(initialState);

  @override
  Stream<LoginStates> mapEventToState(event) async* {
    if (event is AttemptLogin) {
      try {
        yield LoginStates.STARTED;
        final data =
            await _loginRepository.login(event.username, event.password);
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.setString(STORAGE_KEY, data);
        yield LoginStates.SUCCESS;
      } catch (e) {
        print(e);
        yield LoginStates.FAILURE;
      }
    }
  }
}
