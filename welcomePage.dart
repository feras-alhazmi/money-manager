
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'appstate.dart';
//import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height*0.5625000000001,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color.fromARGB(255, 150, 241, 64), Theme.of(context).primaryColor])),
                  
                child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
          
                        const SizedBox(
                          height: 50),
                       Consumer<ApplicationState>(
                    builder: (context, appState, _) => Authentication(
                      email: appState.email,
                      loginState: appState.loginState,
                      startLoginFlow: appState.startLoginFlow,
                      verifyEmail: appState.verifyEmail,
                      signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
                      cancelRegistration: appState.cancelRegistration,
                      registerAccount: appState.registerAccount,
                      signOut: appState.signOut,
                      resetPassword: appState.resetPassword,
                    ),
                ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ]
        ),
    );
  }
}
