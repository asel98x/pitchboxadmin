class PersonalInfoStep {
  late String firstName;
  late String lastName;
  late String email;
  late String phone;

  PersonalInfoStep({required this.firstName, required this.lastName, required this.email, required this.phone});
}



class AddressStep {
  late String street;
  late String city;
  late String state;
  late String zipCode;

  AddressStep({required this.street, required this.city, required this.state, required this.zipCode});
}

class PaymentStep {
  late String cardNumber;
  late String expirationDate;
  late String cvv;

  PaymentStep({required this.cardNumber, required this.expirationDate, required this.cvv});
}

