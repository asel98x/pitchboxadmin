 import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  String _loanId;
  String _userId;
  String _businessId;
  String _businessName;
  String _loanAmount;
  String _loanDescription;
  String _status;

  Loan({
    required String loanId,
    required String userId,
    required String businessId,
    required String businessName,
    required String loanAmount,
    required String loanDescription,
    required String status,
  })  : _loanId = loanId,
        _userId = userId,
        _businessId = businessId,
        _businessName = businessName,
        _loanAmount = loanAmount,
        _loanDescription = loanDescription,
        _status = status;

  String get loanId => _loanId;
  set loanId(String loanId) => _loanId = loanId;

  String get userId => _userId;
  set userId(String userId) => _userId = userId;

  String get businessId => _businessId;
  set businessId(String businessId) => _businessId = businessId;

  String get businessName => _businessName;
  set businessName(String businessName) => _businessName = businessName;

  String get loanAmount => _loanAmount;
  set loanAmount(String loanAmount) => _loanAmount = loanAmount;

  String get loanDescription => _loanDescription;
  set loanDescription(String loanDescription) => _loanDescription = loanDescription;

  String get status => _status;
  set status(String status) => _status = status;

  factory Loan.fromSnapshot(DocumentSnapshot snapshot) {
    return Loan(
      loanId: snapshot.id,
      userId: snapshot['userId'],
      businessId: snapshot['businessId'],
      businessName: snapshot['businessName'],
      loanAmount: snapshot['loanAmount'],
      loanDescription: snapshot['loanDescription'],
      status: snapshot['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loanId': loanId,
      'userId': userId,
      'businessId': businessId,
      'businessName': businessName,
      'loanAmount': loanAmount,
      'loanDescription': loanDescription,
      'status': status,
    };
  }
}
