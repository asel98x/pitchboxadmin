import 'package:pitchboxadmin/backend/model/business.dart';

abstract class BusinessInterface {
  void addNewBusiness(Business business);
  Future<List<Business>> getNewBusinessesList();
  Future<List<Business>> getNewBusiness(String businessName);
  Future<List<String>> getNewBusinessNames();
  Future<void> updateNewBusiness(Business business);
  Future<void> deleteNewBusiness(String businessId);
}