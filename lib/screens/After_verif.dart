import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_portal/screens/Homepage.dart';

class After_verif extends StatefulWidget{
  static const String id = 'After_verif';
  _After_verifState createState() => _After_verifState();
}

class _After_verifState extends State<After_verif>{
  bool datafound = true; //value recieved from sql server
  IconData _icon;
  String _txt;
  Color _clr;


  void initState() {

    if(datafound==true){
      _icon = Icons.verified_user;
      _clr = Colors.green;
      _txt = 'You have been Verified. Congratulations 😊';
    }
    else{
      _icon = Icons.info;
      _clr = Colors.red[800];
      _txt = 'Error, Data not Verified';
    }
    super.initState();

  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Container(child: IconButton(icon: Icon(Icons.home), onPressed: () => Navigator.pushNamed(context, Homepage.id))),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(_icon,color: _clr,size: 150.0,),
            SizedBox(
              height: 3.0,
            ),
            Text(_txt,style: TextStyle(fontSize: 18.0),),

          ],
        )
      )

    );
  }
}