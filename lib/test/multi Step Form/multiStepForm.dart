import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  String _address = '';

  int _currentStep = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Step Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              setState(() {
                if (_currentStep < 2) {
                  _currentStep += 1;
                } else {
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep -= 1;
                } else {
                  Navigator.pop(context);
                }
              });
            },
            steps: [
              Step(
                  title: Text('Personal Information'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _firstName = value!;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _lastName = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  isActive: _currentStep == 0,
                  state: _currentStep == 0
                      ? StepState.editing
                      : StepState.complete,
                  ),
              Step(
                title: Text('Contact Information'),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _email = value!;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _phone = value!;
                        });
                      },
                    ),
                  ],
                ),
                isActive: _currentStep == 1,
                state:
                    _currentStep == 1 ? StepState.editing : StepState.indexed,
              ),
              Step(
                title: Text('Address'),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onSaved: (onSavedValue) {
                        setState(() {
                          _address = onSavedValue!;
                        });
                      },
                    ),
                  ],
                ),
                isActive: _currentStep == 2,
                state:
                    _currentStep == 2 ? StepState.editing : StepState.indexed,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
