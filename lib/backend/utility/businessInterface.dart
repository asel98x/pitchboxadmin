import 'package:pitchboxadmin/backend/model/business.dart';

abstract class BusinessInterface {
  void addNewBusiness(Business business);
  Future<List<Business>> getNewBusinessesList();
}