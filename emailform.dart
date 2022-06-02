import 'package:flutter/material.dart';
import '../shared/inputdecor.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Sign in with email',style: TextStyle(fontSize: 24,color: Colors.white),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _controller,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Colors.white)
                         ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.callback(_controller.text);
                          }
                        },
                        child: const Text('NEXT',style: TextStyle(color: Colors.green),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}