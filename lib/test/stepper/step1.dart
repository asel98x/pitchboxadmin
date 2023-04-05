import 'package:flutter/material.dart';

class Step1 extends StatefulWidget {
  final Function(String) onNameSaved;

  const Step1({required Key key, required this.onNameSaved}) : super(key: key);

  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Next'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onNameSaved(_name);
              }
            },
          ),
        ],
      ),
    );
  }
}
