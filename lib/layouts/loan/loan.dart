import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/businessController.dart';
import 'package:pitchboxadmin/backend/controller/loanController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/model/loan.dart';
import 'package:pitchboxadmin/layouts/loan/EunBusinessListView.dart';

class LoanPage extends StatefulWidget {
  final String businessId;

  const LoanPage({Key? key, required this.businessId}) : super(key: key);

  //const LoanPage({Key? key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final LoanController _controller = LoanController();
  final BusinessController _Bcontroller = BusinessController();
  final TextEditingController _searchController = TextEditingController();

  List<Loan> _loanList = [];
  late Business business;

  final List<String> _status = ['Pending', 'Confirm', 'Reject'];
  String? _selectedStatus;

  File? _imageFile;
  File? _imageFile2;

  @override
  void initState() {
    super.initState();
    _loadLoanList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadLoanList() async {
    List<Loan> loanList = await _controller.getLoanList();
    setState(() {
      _loanList = loanList;
    });
  }

  void _filterBusinessList(String query) {
    List<Loan> filterLoanList = _loanList
        .where((loan) =>
            loan.businessId.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _loanList = filterLoanList;
    });
  }

  Future<void> _handleRefresh() async {
    _loadLoanList();
  }

  Future<void> getData(String businessId) async {
    business = await _Bcontroller.getBusiness(businessId);
    print(business.fundAmount);
  }

  Future<void> _showLoanDetailsDialog(BuildContext context, Loan loan) async {
    GlobalKey _imageKey = GlobalKey();

    await getData(loan.businessId);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String loanId = loan.loanId;
        String userId = loan.userId;
        String businessId = loan.businessId;
        String loanAmount = loan.loanAmount;
        double loanAmountFloat = double.parse(loanAmount);

        String loanDescription = loan.loanDescription;

        String avaiableFundAmount = business.avaiableFundAmount;
        double availableFundAmountFloat = double.parse(avaiableFundAmount);
        double sum = 0;
        sum = loanAmountFloat + availableFundAmountFloat;
        String availableFundAmountString = sum.toString();

        String name = business.name;
        String mobile = business.mobile;
        String city = business.city;
        String country = business.country;
        List<String> professionalExperience = business.professionalExperience;
        List<String> entrepreneurshipExperience = business.entrepreneurshipExperience;
        List<String> education = business.education;
        List<String> industryCertifications = business.industryCertifications;
        List<String> awardsAchievements = business.awardsAchievements;
        List<String> trackRecord = business.trackRecord;
        String email = business.email;
        String facebook = business.facebook;
        String twitter = business.twitter;
        String instagram = business.instagram;
        String linkedin = business.linkedin;
        String Userwebsite = business.Userwebsite;
        String userImageDownloadUrl =business.UserImgUrl;

        String businessName = business.businessName;
        String businessIndustry = business.businessIndustry;
        List<String> industryFocus = business.industryFocus;
        String businessLocation = business.businessLocation;
        String companyDescription = business.companyDescription;
        String website = business.website;
        String executiveSummary = business.executiveSummary;
        String businessModel = business.businessModel;
        String valueProposition = business.valueProposition;
        String productOrServiceOffering = business.productOrServiceOffering;
        String fundingNeeds = business.fundingNeeds;
        String businessImageDownloadUrl = business.businessImgUrl;

        String fundAmount = business.fundAmount;
        String fundPurpose = business.fundPurpose;
        String timeline = business.timeline;
        String fundingSources = business.fundingSources;
        String investmentTerms = business.investmentTerms;
        String investorBenefits = business.investorBenefits;
        String riskFactors = business.riskFactors;

        String minimumInvestmentAmount = business.minimumInvestmentAmount;
        String maximumInvestmentAmount = business.maximumInvestmentAmount;
        String investorLocation = business.investorLocation;
        String investmentStage = business.investmentStage;
        String status = business.status;


        try {
          _Bcontroller.updateNewBusiness(
              id: businessId,
              userId: userId,
              name: name,
              mobile: mobile,
              city: city,
              country: country,
              professionalExperience: professionalExperience,
              entrepreneurshipExperience: entrepreneurshipExperience,
              education: education,
              industryCertifications: industryCertifications,
              awardsAchievements: awardsAchievements,
              trackRecord: trackRecord,
              email: email,
              linkedin: linkedin,
              twitter: twitter,
              facebook: facebook,
              instagram: instagram,
              Userwebsite: Userwebsite,
              UserImgUrl: _imageFile,


              businessName: businessName,
              businessIndustry: businessIndustry,
              businessLocation: businessLocation,
              executiveSummary: executiveSummary,
              companyDescription: companyDescription,
              businessModel: businessModel,
              valueProposition: valueProposition,
              productOrServiceOffering: productOrServiceOffering,
              fundingNeeds: fundingNeeds,
              website: website,
              businessImgUrl: _imageFile2,

              fundAmount: fundAmount,
              avaiableFundAmount: availableFundAmountString,
              fundPurpose: fundPurpose,
              timeline: timeline,
              fundingSources: fundingSources,
              investmentTerms: investmentTerms,
              investorBenefits: investorBenefits,
              riskFactors: riskFactors,

              minimumInvestmentAmount: minimumInvestmentAmount,
              maximumInvestmentAmount: maximumInvestmentAmount,
              investmentStage: investmentStage,
              industryFocus: industryFocus,
              investorLocation: investorLocation,
              status: status,
              street: '',
              state: '',
              zipCode: '',
              industry: '',
              provider: '',
              pass: '',
              investmentGoal: '',
              investmentCriteria: '',
              image: null,
              userImageDownloadUrl: userImageDownloadUrl,
              businessImageDownloadUrl: businessImageDownloadUrl);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error'),
            ),
          );
          print(e.toString());
        }

        return AlertDialog(
          title: Text('Loan Information'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Business : ' + businessId,
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'User : ' + userId,
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Loan Amount',
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 16.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '\$' + loanAmount,
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 16.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Loan Description',
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 16.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          loanDescription,
                          textAlign: TextAlign.justify,
                          style: ralewayStyle.copyWith(
                            fontSize: 16.0,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Status',
                          ),
                          items: _status.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStatus = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a status';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String status = _selectedStatus.toString();
                  String loanId2 = loanId;
                  String businessId2 = businessId;
                  String businessName2 = businessName;
                  String loanAmount2 = loanAmount;
                  String loanDescription2 = loanDescription;
                  String userId2 = userId;


                  await _controller.updateLoan(loanId, userId, businessId,businessName,loanAmount, loanDescription, status);
                  if (status == 'Pending') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User Loan Pending!')),
                    );
                  } else if (status == 'Confirm') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User Loan confirmed!')),
                    );
                  } else if (status == 'Reject') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User Loan Rejected!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error!')),
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.blueDarkColor, // Set status bar color
    ));
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          color: Colors.grey[200], // set the background color to gray
          child: Scaffold(
            appBar: AppBar(
              title: Text('P I T C H B O X'),
              backgroundColor: AppColors.mainBlueColor,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Business Id',
                      hintText: 'Enter a Business Id',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      _filterBusinessList(value);
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: _loanList.isEmpty
                        ? Center(
                            child: Text('No Loan found'),
                          )
                        : ListView.builder(
                            itemCount: _loanList.length,
                            itemBuilder: (context, index) {
                              Loan loan = _loanList[index];
                              return GestureDetector(
                                onTap: () {
                                  _showLoanDetailsDialog(context, loan);
                                },
                                onLongPress: () {},
                                child: Card(
                                  margin: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Business Id : ' +
                                                  loan.businessId,
                                              style: ralewayStyle.copyWith(
                                                fontSize: 16,
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              'Loan Amount :\$' +
                                                  loan.loanAmount,
                                              style: ralewayStyle.copyWith(
                                                fontSize: 20.0,
                                                color: AppColors.blueDarkColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return EunBusinessListView(businessId: loan.businessId,);
                                                },
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColors.mainBlueColor,
                                          ),
                                          child: Text(
                                            'View Business',
                                            style: ralewayStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.whiteColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
