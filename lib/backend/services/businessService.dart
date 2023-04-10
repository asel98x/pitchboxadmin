import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/utility/businessInterface.dart';

class BusinessService implements BusinessInterface{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Entrepreneur');

  @override
  Future<DocumentReference> addNewBusiness(Business business) async{
    final docRef = usersCollection.doc();

    await docRef.set({
      'id': docRef.id,
      'name': business.businessId,
      'name': business.userId,
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
      'website': business.website,

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
        professionalExperience:doc['professionalExperience'],
        entrepreneurshipExperience:doc['entrepreneurshipExperience'],
        education: doc['education'],
        industryCertifications:doc['industryCertifications'],
        awardsAchievements: doc['awardsAchievements'],
        trackRecord: doc['trackRecord'],
        email: doc['email'],
        linkedin: doc['linkedin'],
        twitter: doc['twitter'],
        facebook: doc['facebook'],
        instagram: doc['instagram'],
        Userwebsite: doc['Userwebsite'],
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
        industryFocus: doc['industryFocus'],
        investorLocation: doc['investorLocation'],
      );
      newBusinesses.add(business);
    });

    return newBusinesses;
  }
}