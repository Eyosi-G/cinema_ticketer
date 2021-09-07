abstract class LoginEvents {}

class AttemptLogin extends LoginEvents {
  final String username;
  final String password;
  AttemptLogin(this.username, this.password);
}
