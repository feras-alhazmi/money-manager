import 'package:flutter/material.dart';
import '../shared/inputdecor.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm(
      {required this.login,
       required this.email,
       required this.cancel,
       required this.resetPassword});
  final String email;
  final void Function() cancel;
  final void Function(String email, String password) login;
  final void Function(String email) resetPassword;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('You are Registered Sign in',
            style: TextStyle(fontSize: 24)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: inputdecor.copyWith(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    onEditingComplete: () {
                      if (_formKey.currentState!.validate()) {
                        widget.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    controller: _passwordController,
                    decoration: inputdecor.copyWith(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            final text = _emailController.text.toString();
                            widget.resetPassword(_emailController.text);
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5625000000001,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Color.fromARGB(255, 202, 240, 169),
                                            Theme.of(context).primaryColor
                                          ])),
                                      child: Center(
                                          child: Text(
                                        'Reset your password email has been sent to {$text}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                      )));
                                });
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Text(
                                      'forgot your Password ?',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ]))),
                      const SizedBox(width: 16),
                      ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Colors.white)
                         ),
                        onPressed: widget.cancel,
                        child: const Text('BACK',style: TextStyle(color: Colors.green),),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
