

import 'package:flutter/material.dart';
import 'package:pitchboxadmin/backend/model/loan.dart';
import 'package:pitchboxadmin/backend/services/loanService.dart';

class LoanController {
  final _loanService = LoanService();

  Future<void> addLoan({
    required String loanId,
    required String userId,
    required String businessId,
    required String businessName,
    required String loanAmount,
    required String loanDescription,
    required String status,

  })async {
    final loan = Loan(
        loanId: loanId,
        userId: userId,
        businessId: businessId,
      businessName: businessName,
        loanAmount: loanAmount,
        loanDescription: loanDescription,
        status: status,
    );

    await _loanService.addLoan(loan);

  }

  Future<List<Loan>> getLoanList() async {
    List<Loan> LoanList = await _loanService.getLoanList();
    return LoanList;
  }

  Future<void> updateLoan(
      String loanId,
      String userId,
      String businessId,
      String businessName,
      String loanAmount,
      String loanDescription,
      String status) async {
    try {
      if (loanId == null || loanId.isEmpty) {
        debugPrint('Error updating loan: loanId is null or empty');
        return;
      }

      Loan loan = Loan(
          loanId: loanId,
          userId: userId,
          businessId: businessId,
          businessName: businessName,
          loanAmount: loanAmount,
          loanDescription: loanDescription,
          status: status);

      await _loanService.updateLoan(loanId, loan);
    } catch(e) {
      debugPrint('Error updating loan: $e');
    }
  }

}