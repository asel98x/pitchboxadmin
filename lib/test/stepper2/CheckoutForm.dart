import 'package:flutter/material.dart';
import 'package:pitchboxadmin/test/stepper2/AddressForm.dart';
import 'package:pitchboxadmin/test/stepper2/PaymentForm.dart';
import 'package:pitchboxadmin/test/stepper2/PersonalInfoForm.dart';
import 'package:pitchboxadmin/test/stepper2/PersonalInfoStep.dart';

class CheckoutForm extends StatefulWidget {
  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  int _currentStep = 0;

  PersonalInfoStep _personalInfoStep = PersonalInfoStep(firstName: '', lastName: '', email: '', phone: '');
  AddressStep _addressStep = AddressStep(street: '', city: '', state: '', zipCode: '');
  PaymentStep _paymentStep = PaymentStep(cardNumber: '', expirationDate: '', cvv: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _goToNextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _currentStep,
                controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) => Container(),
                steps: <Step>[
                  Step(
                    state: _currentStep <= 0 ? StepState.editing : StepState.complete,
                    isActive: _currentStep >= 0,
                    title: Text('Personal Information'),
                    content: PersonalInfoForm(
                      personalInfoStep: _personalInfoStep,
                      onNext: _goToNextStep,
                    ),
                  ),
                  Step(
                    state: _currentStep <= 1 ? StepState.editing : StepState.complete,
                    isActive: _currentStep >= 1,
                    title: Text('Shipping Address'),
                    content: AddressForm(
                      addressStep: _addressStep,
                      onNext: _goToNextStep,
                    ),
                  ),
                  Step(
                    state: StepState.complete,
                    isActive: _currentStep >= 0,
                    title: Text('Payment Information'),
                    content: PaymentForm(
                      paymentStep: _paymentStep,
                      onSubmit: () {
                        // Submit the form data
                      },
                      onPrevious: _goToPreviousStep,
                    ),
                  ),
                ],
              ),
            ),
            if (_currentStep == 2)
              ElevatedButton(
                child: Text('Place Order'),
                onPressed: () {
                  print(_personalInfoStep.firstName);

                },
              ),
          ],
        ),
      ),
    );
  }

}
