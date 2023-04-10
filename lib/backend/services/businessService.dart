import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/utility/businessInterface.dart';

class BusinessService implements BusinessInterface{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('startup');

  @override
  Future<DocumentReference> addNewBusiness(Business business) async{
    final docRef = usersCollection.doc();


    await docRef.set({
      'id': docRef.id,
      'businessId': business.businessId,
      'userId': business.userId,
      'name': business.name,
      'mobile': business.mobile,
      'city': business.city,
      'country': business.country,
      'professionalExperience': business.professionalExperience,
      'entrepreneurshipExperience': business.entrepreneurshipExperience,
      'education': business.education,
      'industryCertifications': business.industryCertifications,
      'awardsAchievements': business.awardsAchievements,
      'trackRecord': business.trackRecord,
      'email': business.email,
      'linkedin': business.linkedin,
      'facebook': business.facebook,
      'twitter': business.twitter,
      'instagram': business.instagram,
      'Userwebsite': business.Userwebsite,
      'UserImgUrl': business.UserImgUrl,

      'businessName': business.businessName,
      'businessIndustry': business.businessIndustry,
      'businessLocation': business.businessLocation,
      'executiveSummary': business.executiveSummary,
      'companyDescription': business.companyDescription,
      'businessModel': business.businessModel,
      'valueProposition': business.valueProposition,
      'productOrServiceOffering': business.productOrServiceOffering,
      'fundingNeeds': business.fundingNeeds,
      'website': business.website,
      'businessImgUrl': business.businessImgUrl,

      'fundAmount': business.fundAmount,
      'fundPurpose': business.fundPurpose,
      'timeline': business.timeline,
      'fundingSources': business.fundingSources,
      'investmentTerms': business.investmentTerms,
      'investorBenefits': business.investorBenefits,
      'riskFactors': business.riskFactors,

      'minimumInvestmentAmount': business.minimumInvestmentAmount,
      'maximumInvestmentAmount': business.maximumInvestmentAmount,
      'investorLocation': business.investorLocation,
      'investmentStage': business.investmentStage,
      'industryFocus': business.industryFocus,
      'status': business.status,
    });
    return docRef;
  }
  Future<List<Business>> getNewBusinessesList() async {
    QuerySnapshot querySnapshot = await usersCollection.get();

    List<Business> newBusinesses = [];

    querySnapshot.docs.forEach((doc) {
      Business business = Business(
        id: doc.id, // use Firebase's document ID as the business ID
        businessId: doc['businessId'],
        userId: doc['userId'],
        name: doc['name'],
        mobile: doc['mobile'],
        city: doc['city'],
        country: doc['country'],
        professionalExperience: (doc['professionalExperience'] as List<dynamic>).cast<String>(),
        entrepreneurshipExperience:(doc['entrepreneurshipExperience'] as List<dynamic>).cast<String>(),
        education: (doc['education'] as List<dynamic>).cast<String>(),
        industryCertifications:(doc['industryCertifications'] as List<dynamic>).cast<String>(),
        awardsAchievements: (doc['awardsAchievements'] as List<dynamic>).cast<String>(),
        trackRecord: (doc['trackRecord'] as List<dynamic>).cast<String>(),
        email: doc['email'],
        linkedin: doc['linkedin'],
        twitter: doc['twitter'],
        facebook: doc['facebook'],
        instagram: doc['instagram'],
        Userwebsite: doc['Userwebsite'],
        UserImgUrl: doc['UserImgUrl'],
        businessIndustry: doc['businessIndustry'],
        businessName: doc['businessName'],
        businessLocation: doc['businessLocation'],
        companyDescription: doc['companyDescription'],
        website: doc['website'],
        executiveSummary: doc['executiveSummary'],
        businessModel: doc['businessModel'],
        valueProposition: doc['valueProposition'],
        productOrServiceOffering: doc['productOrServiceOffering'],
        fundingNeeds: doc['fundingNeeds'],
        businessImgUrl: doc['businessImgUrl'],
        fundAmount: doc['fundAmount'],
        fundPurpose: doc['fundPurpose'],
        timeline: doc['timeline'],
        fundingSources: doc['fundingSources'],
        investmentTerms: doc['investmentTerms'],
        investorBenefits: doc['investorBenefits'],
        riskFactors: doc['riskFactors'],
        minimumInvestmentAmount: doc['minimumInvestmentAmount'],
        maximumInvestmentAmount: doc['maximumInvestmentAmount'],
        investmentStage: doc['investmentStage'],
        industryFocus: (doc['industryFocus'] as List<dynamic>).cast<String>(),
        investorLocation: doc['investorLocation'],
        status: doc['status'],
      );
      newBusinesses.add(business);
    });

    return newBusinesses;
  }

  @override
  Future<List<Business>> getNewBusiness(String businessName) async{
    QuerySnapshot querySnapshot = await _firestore
        .collection('startup')
        .where('businessName', isEqualTo: businessName)
        .get();
    List<Business> business = [];
    querySnapshot.docs.forEach((doc) {
      business.add(Business.fromSnapshot(doc));
    });
    return business;
  }

  @override
  Future<List<String>> getNewBusinessNames() async{
    QuerySnapshot querySnapshot = await _firestore.collection('startup').get();
    List<String> businessNames = [];
    querySnapshot.docs.forEach((doc) {
      businessNames.add(doc.get('businessName'));
    });
    return businessNames;
  }

  @override
  Future<void> deleteNewBusiness(String businessId) async{
    await _firestore.collection('startup').doc(businessId).delete();
  }

  @override
  Future<void> updateNewBusiness(Business business) async{
    await _firestore
        .collection('industries')
        .doc(business.id)
        .update(business.toMap());
  }
}