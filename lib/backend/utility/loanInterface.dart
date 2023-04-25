
import 'package:pitchboxadmin/backend/model/loan.dart';

abstract class loanInterface {
  void addLoan(Loan loan);
  Future<List<Loan>> getLoanList();
  Future<void> updateLoan(String loanId,Loan loan);
}