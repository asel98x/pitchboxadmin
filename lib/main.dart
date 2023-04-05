import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pitchboxadmin/layouts/dashboard.dart';
import 'package:pitchboxadmin/layouts/loginScreen.dart';
import 'package:pitchboxadmin/test/grid/myHomePage.dart';
import 'package:pitchboxadmin/test/multi%20Step%20Form/multiStepForm.dart';
import 'package:pitchboxadmin/test/stepper/MyStepper.dart';
import 'package:pitchboxadmin/test/stepper2/CheckoutForm.dart';

import 'test oop/layers/addUserScreen.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBkQo19Rg1HQYkr3pGMX8pWmAR7BdwzMvc",
            authDomain: "pitchbox-9db19.firebaseapp.com",
            projectId: "pitchbox-9db19",
            storageBucket: "pitchbox-9db19.appspot.com",
            messagingSenderId: "786693006478",
            appId: "1:786693006478:web:bc6919b1290f0d8c8f55df",
            measurementId: "G-NY5Q6467V9" )
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PITCHBOX Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

