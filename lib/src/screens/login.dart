import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordHidden = true;
  final Map<String, dynamic> _form = {};
  final _formKey = GlobalKey<FormState>();
  BuildContext _dialogCtx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<LoginBloc, LoginStates>(
        listener: (ctx, state) async {
          switch (state) {
            case LoginStates.STARTED:
              {
                await showDialog(
                  context: context,
                  builder: (_ctx) {
                    _dialogCtx = _ctx;
                    return AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text('Loading...'),
                        ],
                      ),
                    );
                  },
                );
                break;
              }
            case LoginStates.SUCCESS:
              {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Home.routeName,
                  ModalRoute.withName(Home.routeName),
                );
                break;
              }
            case LoginStates.FAILURE:
              {
                if (_dialogCtx != null) Navigator.of(_dialogCtx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('login failed!'),
                  ),
                );
              }
          }
        },
        child: Container(
            margin: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "username",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    validator: (value) {
                      return value.length < 4 ? 'username is incorrect' : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _form["username"] = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "password",
                      prefixIcon: GestureDetector(
                        child: _isPasswordHidden
                            ? Icon(Icons.lock)
                            : Icon(Icons.lock_open),
                        onTap: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: _isPasswordHidden,
                    onSaved: (value) => setState(() {
                      _form["password"] = value;
                    }),
                    validator: (value) {
                      print(value);
                      return value.length < 6 ? 'password is incorrect' : null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        context.read<LoginBloc>()
                          ..add(
                            AttemptLogin(_form["username"], _form["password"]),
                          );
                      }
                    },
                    child: Text('LOGIN'),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
