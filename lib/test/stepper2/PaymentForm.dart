import 'package:flutter/material.dart';
import 'package:pitchboxadmin/test/stepper2/PersonalInfoStep.dart';

class PaymentForm extends StatefulWidget {
  final PaymentStep paymentStep;
  final Function onPrevious;
  final Function onSubmit;

  PaymentForm({required this.paymentStep, required this.onPrevious, required this.onSubmit});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.paymentStep != null) {
      _cardNumberController.text = widget.paymentStep.cardNumber;
      _expirationDateController.text = widget.paymentStep.expirationDate;
      _cvvController.text = widget.paymentStep.cvv;
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
            controller: _cardNumberController,
            decoration: InputDecoration(
              labelText: 'Card Number',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your card number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _expirationDateController,
            decoration: InputDecoration(
              labelText: 'Expiration Date (MM/YY)',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your expiration date';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cvvController,
            decoration: InputDecoration(
              labelText: 'CVV',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your CVV';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text('Previous'),
                onPressed: () {
                  widget.onPrevious(widget.paymentStep, -1);
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.paymentStep.cardNumber = _cardNumberController.text;
                    widget.paymentStep.expirationDate = _expirationDateController.text;
                    widget.paymentStep.cvv = _cvvController.text;
                    widget.onSubmit();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
