import 'package:flutter/material.dart';
import 'step1.dart';
import 'step2.dart';
import 'step3.dart';

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name = '';
  late String _email = '';
  late String _password = '';

  void _onNameSaved(String value) {
    setState(() {
      _name = value;
    });
  }

  void _onDetailsSaved(String email, String password) {
    setState(() {
      _email = email;
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Step> _steps = [
      Step(
        title: Text('Step 1'),
        content: Step1(onNameSaved: _onNameSaved, key: _formKey,),
      ),
      Step(
        title: Text('Step 2'),
        content: Step2(onDetailsSaved: _onDetailsSaved, key: _formKey,),
      ),
      Step(
        title: Text('Step 3'),
        content: Step3(
          name: _name,
          email: _email,
          password: _password ,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Stepper'),
      ),
      body: Container(
        child: Stepper(
          key: _formKey,
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < _steps.length - 1) {
                _currentStep++;
              } else {
                _formKey.currentState?.save();
                // Do something with the form data
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              } else {
                _currentStep = 0;
              }
            });
          },
          steps: _steps,
        ),
      ),
    );
  }
}
