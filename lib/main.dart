
import 'dart:io';

import 'package:authenticate_app/NxtPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalAuthentication auth = LocalAuthentication();



  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
      _getListOfBiometricTypes();
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();
    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        final authenticated=await auth.authenticateWithBiometrics(
          localizedReason:'Enable Face ID to sign in more easily'
        );
        if(authenticated){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> NxtPage()));
        }
        // Face ID.
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
    }

    try {
      listofBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    _canCheckBiometric;

    try {
      isAuthorized = await auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate ",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    //_getListOfBiometricTypes;

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = " you are Authorized";
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NxtPage()));
        _checkBiometric();

      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Authenticate using Flutter'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30.0),
              height: 200.0,
            width: 400.0,
            child: new Image.asset('assets/auth1.png'),
              alignment: Alignment.center,
             // color: Colors.grey,
            ),
            SizedBox(height: 5.0,),
            Text(" Check wheather Biometric is available : $_canCheckBiometric"),
            SizedBox(height:5.0),
            Text("available Biometric : ${_availableBiometricTypes.toString()}"),
            SizedBox(height:20.0),
            RaisedButton(
              onPressed: _checkBiometric,
              child: Text("Check Biometric",style: TextStyle(color: Colors.white),),
              color: Colors.pink,
              colorBrightness: Brightness.light,
              elevation: 12.0,
            ),
            SizedBox(height:20.0),
            Text("Authorized : $_authorizedOrNot"),
            SizedBox(height:20.0),
            RaisedButton(
              onPressed: _authorizeNow,
              child: Text("Authorize ",style: TextStyle(color: Colors.white),),
              color: Colors.pink,
              colorBrightness: Brightness.light,
              elevation: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}