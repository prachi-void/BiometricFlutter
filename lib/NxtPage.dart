import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NxtPage extends StatefulWidget {

  @override
  _NxtPageState createState() => _NxtPageState();
}

class _NxtPageState extends State<NxtPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Authenticate using Flutter'),
          backgroundColor: Colors.pink,
        ),
    body:Center(
      child: Container(
        margin: EdgeInsets.only(right:20.0,left: 20.0,top:60.0,bottom: 20.0),
        padding: EdgeInsets.all(10.0),

        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:40.0),
              height: 250.0,
              width: 250.0,
              child: new Image.asset('assets/green.png'),
              alignment: Alignment.center,

            ),
            SizedBox(height: 30.0,),
            Text('Authentication is done successfully :)',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize:15.0,color: Colors.black54),)


          ],
        ),
      ),
    ));

  }

}