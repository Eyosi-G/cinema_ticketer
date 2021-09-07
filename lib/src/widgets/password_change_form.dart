import 'package:flutter/material.dart';

class PasswordChangeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _oldPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _oldPasswordVisibility = false;
    bool _newPasswordVisibility = false;
    return StatefulBuilder(
      builder: (ctx, setState) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: !_oldPasswordVisibility,
                  validator: (value) =>
                      value.length < 6 ? "invalid password length" : null,
                  decoration: InputDecoration(
                    prefixIcon: _oldPasswordVisibility
                        ? IconButton(
                            icon: Icon(Icons.visibility),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _oldPasswordVisibility = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.visibility_off),
                            color: Colors.black,
                            onPressed: () {
                              print('set old password visibile');
                              setState(() {
                                _oldPasswordVisibility = true;
                              });
                            },
                          ),
                    labelText: "old password",
                  ),
                ),
                TextFormField(
                  obscureText: !_newPasswordVisibility,
                  controller: _newPasswordController,
                  validator: (value) =>
                      value.length < 6 ? "invalid password length" : null,
                  decoration: InputDecoration(
                    prefixIcon: _newPasswordVisibility
                        ? IconButton(
                            icon: Icon(Icons.visibility),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _newPasswordVisibility = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.visibility_off),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _newPasswordVisibility = true;
                              });
                            },
                          ),
                    labelText: "new password",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('change'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final data = ({
                    "oldpassword": _oldPasswordController.text,
                    "newpassword": _newPasswordController.text
                  });
                  _oldPasswordController.text = "";
                  _newPasswordController.text = "";
                  Navigator.of(context).pop(data);
                }
              },
            )
          ],
        );
      },
    );
  }
}
