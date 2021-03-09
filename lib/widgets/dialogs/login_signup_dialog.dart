import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';

class LoginSignUpDialog extends StatefulWidget {
  @override
  _LoginSignUpDialogState createState() => _LoginSignUpDialogState();
}

class _LoginSignUpDialogState extends State<LoginSignUpDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _wrongCredentials = false;
  bool _signUp = false;

  @override
  Widget build(BuildContext context) {
    final textFields = !_signUp
        ? [
            _textField("Email / Username"),
            _textField("Password"),
          ]
        : [
            _textField("Email"),
            _textField("Username"),
            _textField("Password"),
            _textField("Confirm Password"),
          ];

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
            child: Container(
              width: 300,
              child: Column(
                children: [
                  ...textFields,
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
                            _signUp ? "Sign up" : "Login",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                    onPressed: _isLoading ? null : _loginSignup,
                  ),
                  Padding(padding: const EdgeInsets.all(8.0)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _signUp = !_signUp;
                      });
                    },
                    child: Text(
                      _signUp ? "Login instead" : "Sign up instead",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(String label) {
    return TextFormField(
      controller: _getControllerForLabel(label),
      decoration: InputDecoration(
        icon: _getIconForLabel(label),
        labelText: label,
      ),
      onChanged: _onChanged,
      obscureText: label.compareTo("Password") == 0 ||
          label.compareTo("Confirm Password") == 0,
      validator: (value) => _getValidatorForLabel(label, value),
    );
  }

  Icon _getIconForLabel(String label) {
    switch (label) {
      case 'Email / Username':
        return Icon(Icons.person);

      case "Password":
        return Icon(Icons.security);

      case "Email":
        return Icon(Icons.email);

      case "Username":
        return Icon(Icons.person);

      case "Confirm Password":
        return Icon(Icons.security);

      default:
        return Icon(Icons.error);
    }
  }

  void _onChanged(_) {
    if (_wrongCredentials) {
      setState(() {
        _wrongCredentials = false;
      });
    }
  }

  String? _getValidatorForLabel(String label, String? value) {
    switch (label) {
      case 'Email / Username':
        if (value != null && value.trim().isEmpty) {
          return 'Please enter your email or username';
        }

        return null;

      case "Password":
        if (value != null && value.trim().isEmpty) {
          return 'Please enter your password';
        }

        if (_wrongCredentials && !_signUp) {
          return 'Your email/username or password is wrong';
        }

        return null;

      case "Email":
        if (value != null && value.trim().isEmpty) {
          return 'Please enter your email.';
        }

        if (_wrongCredentials) {
          return 'Email/Username already exists or is not allowed.';
        }

        return null;

      case "Username":
        if (value != null && value.trim().isEmpty) {
          return 'Please enter your username.';
        }

        if (_wrongCredentials) {
          return 'Email/Username already exists or is not allowed.';
        }

        return null;

      case "Confirm Password":
        if (value != null && value.trim().isEmpty) {
          return 'Please confirm your password';
        }

        if (value != null && value.compareTo(_passwordController.text) != 0) {
          return 'Does not match your password';
        }

        return null;
      default:
        return null;
    }
  }

  TextEditingController _getControllerForLabel(String label) {
    switch (label) {
      case 'Email / Username':
        return _emailController;

      case "Password":
        return _passwordController;

      case "Email":
        return _emailController;

      case "Username":
        return _usernameController;

      case "Confirm Password":
        return _confirmPasswordController;

      default:
        return TextEditingController();
    }
  }

  void _loginSignup() {
    var controller = Get.find<AuthController>();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _wrongCredentials = false;
        _isLoading = true;
      });

      if (_signUp) {
        controller
            .signUp(
                _emailController.text.trim(),
                _usernameController.text.trim(),
                _passwordController.text.trim())
            .then((value) {
          if (value) {
            Navigator.pop(context);
          } else {
            setState(() {
              _wrongCredentials = true;
              _isLoading = false;
              _formKey.currentState!.validate();
            });
          }
        });
      } else {
        controller
            .login(
                _emailController.text.trim(), _passwordController.text.trim())
            .then((value) {
          if (value) {
            Navigator.pop(context);
          } else {
            setState(() {
              _wrongCredentials = true;
              _isLoading = false;
              _formKey.currentState!.validate();
            });
          }
        });
      }
    }
  }
}
