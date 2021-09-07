import 'package:cinema_ticketer/src/config/config.dart';
import 'package:cinema_ticketer/src/data_providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../repositories/repositories.dart';

enum Selected { LOGOUT }

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(STORAGE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(
      Login.routeName,
      ModalRoute.withName(Login.routeName),
    );
  }

  ChangePasswordBloc _changePasswordBloc;
  BuildContext _loadingContext;

  @override
  void initState() {
    _changePasswordBloc = ChangePasswordBloc(
        ChangePasswordRepository(ChangePasswordDataProvider()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 2),
                      Text('logout'),
                    ],
                  ),
                  value: Selected.LOGOUT,
                ),
              ];
            },
            onSelected: (Selected selected) {
              if (selected == Selected.LOGOUT) {
                logout(context);
              }
            },
          )
        ],
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        bloc: _changePasswordBloc,
        builder: (ctx, state) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final Map<String, String> data = await showDialog(
                      barrierDismissible: false,
                      builder: (ctx) => PasswordChangeForm(),
                      context: context,
                    );
                    if (data != null) {
                      _changePasswordBloc.add(
                        ChangePasswordEvent(
                          data["oldpassword"],
                          data["newpassword"],
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.edit),
                  label: Text('edit password'),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          );
        },
        listener: (ctx, state) async {
          if (state is ChangePasswordSuccess) {
            Navigator.of(_loadingContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text('password successfully changed!')
                  ],
                ),
              ),
            );
          }
          if (state is ChangePasswordStarted) {
            await showDialog(
              context: context,
              builder: (_ctx) {
                _loadingContext = _ctx;
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
          }
          if (state is ChangePasswordFailure) {
            Navigator.of(_loadingContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text('changing password failed!')
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
