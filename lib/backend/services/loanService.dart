import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/loan.dart';
import 'package:pitchboxadmin/backend/utility/loanInterface.dart';

class LoanService implements loanInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('loan');

  @override
  Future<DocumentReference<Object?>> addLoan(loan) async {
    final docRef = userCollection.doc();
    await docRef.set({
      'loanId': docRef.id,
      'userId': loan.userId,
      'businessId': loan.businessId,
      'businessName': loan.businessName,
      'loanAmount': loan.loanAmount,
      'loanDescription': loan.loanDescription,
      'status': loan.status,
    });

    return docRef;
  }


  @override
  Future<List<Loan>> getLoanList() async {
    QuerySnapshot querySnapshot = await _firestore.collection('loan').get();
    List<Loan> loanList = [];

    querySnapshot.docs.forEach((doc) {
      Loan loan = Loan(
        loanId: doc.id,
        userId: doc['userId'],
        businessId: doc['businessId'],
        businessName: doc['businessName'],
        loanAmount: doc['loanAmount'],
        loanDescription: doc['loanDescription'],
        status: '',
      );
      loanList.add(loan);
    });

    return loanList;
  }

  @override
  Future<void> updateLoan(String loanId, Loan loan) async {
    await _firestore.collection('loan').doc(loanId).update(loan.toMap());
  }






}