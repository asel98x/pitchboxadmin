import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  final Function(String, String) onDetailsSaved;

  const Step2({required Key key, required this.onDetailsSaved}) : super(key: key);

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final _formKey2= GlobalKey<FormState>();
  late String _email = '';
  late String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Next'),
            onPressed: () {
              if (_formKey2.currentState!.validate()) {
                _formKey2.currentState!.save();
                widget.onDetailsSaved(_email, _password);
              }
            },
          ),
        ],
      ),
    );
  }
}
