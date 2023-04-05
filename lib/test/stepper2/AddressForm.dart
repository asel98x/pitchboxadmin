import 'package:flutter/material.dart';
import 'package:pitchboxadmin/test/stepper2/PersonalInfoStep.dart';

class AddressForm extends StatefulWidget {
  final AddressStep addressStep;
  final Function onNext;

  AddressForm({required this.addressStep, required this.onNext});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.addressStep != null) {
      _streetController.text = widget.addressStep.street;
      _cityController.text = widget.addressStep.city;
      _stateController.text = widget.addressStep.state;
      _zipCodeController.text = widget.addressStep.zipCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _streetController,
            decoration: InputDecoration(
              labelText: 'Street Address',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your street address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'City',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _stateController,
            decoration: InputDecoration(
              labelText: 'State',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your state';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _zipCodeController,
            decoration: InputDecoration(
              labelText: 'Zip Code',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your zip code';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Next'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.addressStep.street = _streetController.text;
                widget.addressStep.city = _cityController.text;
                widget.addressStep.state = _stateController.text;
                widget.addressStep.zipCode = _zipCodeController.text;
                widget.onNext();
              }
            },
          ),
        ],
      ),
    );
  }
}
