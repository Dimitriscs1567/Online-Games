import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  bool _wrongCredentials = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Login",
        textAlign: TextAlign.center,
      ),
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Email / Username',
                  ),
                  onChanged: (_) {
                    if (_wrongCredentials) {
                      setState(() {
                        _wrongCredentials = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your email or username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.security),
                    labelText: 'Password',
                  ),
                  onChanged: (_) {
                    if (_wrongCredentials) {
                      setState(() {
                        _wrongCredentials = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your password';
                    }

                    if (_wrongCredentials) {
                      return 'Your email/username or password is wrong';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 20.0,
                    )),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                  onPressed: login,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() {
    var controller = Get.find<AuthController>();

    if (_formKey.currentState.validate()) {
      setState(() {
        _wrongCredentials = false;
        _isLoading = true;
      });

      controller
          .login(emailController.text.trim(), passwordController.text.trim())
          .then((value) {
        if (value) {
          Navigator.pop(context);
        } else {
          setState(() {
            _wrongCredentials = true;
            _isLoading = false;
          });
        }
      });
    }
  }
}
