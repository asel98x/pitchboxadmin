import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appIcons.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/loanController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:url_launcher/url_launcher.dart';


class EunBusinessListView extends StatefulWidget {
  Business business;

  EunBusinessListView({required this.business, Key? key}) : super(key: key);

  @override
  _EunBusinessListViewState createState() => _EunBusinessListViewState();
}

class _EunBusinessListViewState extends State<EunBusinessListView> {
  final _formKey = GlobalKey<FormState>();
  String? paymentStatus;
  List<Business> _businessList = [];
  LoanController _loanController = LoanController();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _investAmountController = TextEditingController();

  var _loanAmountController = TextEditingController();
  final _loanDescriptionController = TextEditingController();
  int _number = 0;

  String _userId = '';
  String _name = '';
  String _mobile = '';
  String _city = '';
  String _country = '';
  List<String> _professionalExperience = [];
  List<String> _entrepreneurshipExperience = [];
  List<String> _education = [];
  List<String> _industryCertifications = [];
  List<String> _awardsAchievements = [];
  List<String> _trackRecord = [];
  String _email = '';
  String _linkedin = '';
  String _twitter = '';
  String _facebook = '';
  String _instagram = '';
  String _Userwebsite = '';

  String _businessId = '';
  String _businessName = '';
  String _businessLocation = '';
  String _executiveSummary = '';
  String _companyDescription = '';
  String _businessModel = '';
  String _valueProposition = '';
  String _productOrServiceOffering = '';
  String _fundingNeeds = '';

  String _minimumInvestmentAmount = '';
  String _maximumInvestmentAmount = '';
  String _fundAmount = '';
  String _fundPurpose = '';
  String _timeline = '';
  String _fundingSources = '';
  String _investmentTerms = '';
  String _investorBenefits = '';
  String _riskFactors = '';

  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _loanAmountController = TextEditingController(text: _number.toString());
    paymentStatus = "Not Paid";
    _userId = widget.business.userId;
    _name = widget.business.name;
    _mobile = widget.business.mobile;
    _city = widget.business.city;
    _country = widget.business.country;
    _professionalExperience =
        List<String>.from(widget.business.professionalExperience);
    _entrepreneurshipExperience =
        List<String>.from(widget.business.entrepreneurshipExperience);
    _education = List<String>.from(widget.business.education);
    _industryCertifications =
        List<String>.from(widget.business.industryCertifications);
    _industryCertifications =
        List<String>.from(widget.business.industryCertifications);
    _awardsAchievements = List<String>.from(widget.business.awardsAchievements);
    _trackRecord = List<String>.from(widget.business.trackRecord);
    _email = widget.business.email;

    _businessId = widget.business.id;
    _businessName = widget.business.businessName;
    _businessLocation = widget.business.businessLocation;
    _executiveSummary = widget.business.executiveSummary;
    _companyDescription = widget.business.companyDescription;
    _businessModel = widget.business.businessModel;
    _valueProposition = widget.business.valueProposition;
    _productOrServiceOffering = widget.business.productOrServiceOffering;
    _fundingNeeds = widget.business.fundingNeeds;

    _minimumInvestmentAmount = widget.business.minimumInvestmentAmount;
    _maximumInvestmentAmount = widget.business.maximumInvestmentAmount;
    _fundAmount = widget.business.fundAmount;
    _fundAmount = widget.business.fundAmount;
    _fundPurpose = widget.business.fundPurpose;
    _timeline = widget.business.timeline;
    _fundingSources = widget.business.fundingSources;
    _investmentTerms = widget.business.investmentTerms;
    _investorBenefits = widget.business.investorBenefits;
    _riskFactors = widget.business.riskFactors;
  }

  void _increment() {
    setState(() {
      _number++;
      _loanAmountController.text = _number.toString();
    });
  }

  void _decrement() {
    setState(() {
      if (_number > 0) {
        _number--;
        _loanAmountController.text = _number.toString();
      }
    });
  }

  void _addLoanValues() async {
    try {
      await _loanController.addLoan(
          businessId:_businessId,
          loanAmount: _loanAmountController.text,
          loanDescription: _loanDescriptionController.text,
          loanId: '',
          status: _status,
          userId: _userId
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your loan is successfully submited. Please wait until get approval from the administrator!'),
          )
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get a Loan'),
        ),
      );
      print(e.toString());
    }
  }

  void _showGetLoanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Get a Loan'),
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
                      children: [
                        Text(
                          'Loan Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decrement,
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                controller: _loanAmountController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _number = int.tryParse(value) ?? 0;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a loan amount.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16.0),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _increment,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _loanDescriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Loan Description',
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a loan description.';
                      }
                      return null;
                    },
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_userId);
                  print(_businessId);
                  print(_loanAmountController.text);
                  print(_loanDescriptionController.text);
                  print(_status);
                  _addLoanValues();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showEunDetailsDialog(BuildContext context, Business business) {
    GlobalKey _imageKey = GlobalKey();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrepreneur Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            (widget.business.UserImgUrl),
                          ))),
                ),
                SizedBox(height: 8),
                Text(
                  _name,
                  style: ralewayStyle.copyWith(
                    fontSize: 16.0,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile : ' + _mobile,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'City : ' + _city,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Country  : ' + _country,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email  : ' + _email,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Professional Experience',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _professionalExperience
                            .map(
                              (experience) => Column(
                                children: [
                                  Text(
                                    '• ' + experience,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Entrepreneurship Experience',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _entrepreneurshipExperience
                            .map(
                              (entrepreneurshipExperience) => Column(
                                children: [
                                  Text(
                                    '• ' + entrepreneurshipExperience,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'education',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _education
                            .map(
                              (education) => Column(
                                children: [
                                  Text(
                                    '• ' + education,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Industry Certifications',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _industryCertifications
                            .map(
                              (industryCertifications) => Column(
                                children: [
                                  Text(
                                    '• ' + industryCertifications,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Awards Achievements',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _awardsAchievements
                            .map(
                              (awardsAchievements) => Column(
                                children: [
                                  Text(
                                    '• ' + awardsAchievements,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Track Record',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: _trackRecord
                            .map(
                              (trackRecord) => Column(
                                children: [
                                  Text(
                                    '• ' + trackRecord,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBlueColor,
        title: Text('User Design Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(
                'INVEST IN ' + _businessName,
                style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              Text(
                _businessLocation,
                style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            _executiveSummary,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              Image.network(
                (widget.business.businessImgUrl),
                height: 175,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showEunDetailsDialog(context, widget.business);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.business.UserImgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          launch(_facebook);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.facebookIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_twitter);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.twitterIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_linkedin);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.linkedinIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_instagram);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.instagramIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_Userwebsite);
                        },
                        child: Icon(Icons.language),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'text',
                      textAlign: TextAlign.right,
                      style: ralewayStyle.copyWith(
                        fontSize: 16.0,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            _companyDescription,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Business Model',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 6),
          Text(
            _businessModel,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Value Proposition',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _valueProposition,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Product or Service',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _productOrServiceOffering,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Funding Needs',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _fundingNeeds,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Timeline',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _timeline,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Funding Sources',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _fundingSources,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Investment Benefits',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _investorBenefits,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Investment Terms',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _investmentTerms,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Risk Factors',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _riskFactors,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          SizedBox(width: 16.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _showGetLoanDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.mainBlueColor,
                              ),
                              child: Text(
                                'Get a Loan',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
