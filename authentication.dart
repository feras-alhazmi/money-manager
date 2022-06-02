
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './registerform.dart';
import './passwordform.dart';
import './emailform.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
    required this.resetPassword,
    //required this.name,
  });
  //final name;
  final void Function(
    String email
  ) resetPassword;
  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return InkWell(
      onTap: () {startLoginFlow();
      },
      child: Column(
        children: [
          const Text('save your data and access it from any device', style: TextStyle(color: Colors.white,fontSize: 20),),
          const SizedBox(
            height: 80),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromARGB(255, 134, 223, 51).withAlpha(100),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 2)
                ],
                color: Colors.white),
            child: Text(
              'Login or register',
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid email', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
          resetPassword: (email){
            resetPassword(email);
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
      final name = FirebaseAuth.instance.currentUser!.displayName.toString();
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 8),
              child:ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {
                  signOut();
                },
              child: const Text('LOGOUT',style: TextStyle(color: Colors.green),),
            ),
            ),
            Text('Hello $name'),
          ],
        );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',style: TextStyle(color: Colors.green),),
            ),
          ],
        );
      },
    );
  }
}



