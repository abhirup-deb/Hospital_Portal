import 'package:flutter/material.dart';
import 'package:hospital_portal/screens/Homepage.dart';
import 'package:hospital_portal/screens/Hospital.dart';
import 'package:hospital_portal/screens/Registration.dart';
import 'package:flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hospital_portal/screens/otp.dart';
import 'package:path/path.dart' as p;

class Verification extends StatefulWidget {
  static const String id = 'verification';
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends  State<Verification>{

  bool _validate1 = false;
  bool _validate2 = false;
  final _aadhar = TextEditingController();
  final _register = TextEditingController();
  String filePath;


  @override
  void dispose() {
    _aadhar.dispose();
    _register.dispose();
    super.dispose();
  }
 Certi() async {
   filePath = await FilePicker.getFilePath(type:FileType.ANY);
   print(filePath);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Verification'),
        ),
        drawer: Drawer(child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF01579B),
              ),
              child: Text(
                'Verification',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, Homepage.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Register'),
              onTap: () {
                Navigator.pushNamed(context, Registration.id);
              },
            ),

            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Hospital'),
              onTap: () {
                Navigator.pushNamed(context, Hospital.id);
              },
            ),
          ],
        ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 450.0,
            width: 330.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(27.0),color: Colors.black12),
            child: ListView(

              children: <Widget>[
                Text('Upload Your Certificate for Verification below',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(color:Colors.blue,onPressed: (){
                  Certi();
                  }, child: Text('Upload',style: TextStyle(fontSize: 16.0),)),

                SizedBox(
                  height: 34.0,
                ),
                Container(height: 90.0,width:240.0,
                    child: TextField(style: TextStyle(color: Colors.white70),controller:_aadhar,textAlign: TextAlign.center,decoration: InputDecoration(
                      hintText: 'Enter Your Aadhar Number',hintStyle: TextStyle(color: Colors.blueGrey,),errorText: _validate1?"Please Fill up this Field":null,
                    ),)),
                SizedBox(
                  height: 3.0,
                ),
                Container(height: 90.0,width:240.0,
                    child: TextField(style: TextStyle(color: Colors.white70),controller: _register,keyboardType: TextInputType.emailAddress,textAlign: TextAlign.center,decoration: InputDecoration(
                      hintText: 'Enter Your Registration Number',hintStyle: TextStyle(color: Colors.blueGrey),errorText: _validate2?"Please Fill up this Field":null,
                    ),)),
                SizedBox(
                  height: 3.0,
                ),



                SizedBox(height: 4.0,),
                Center(
                  child: RaisedButton(onPressed: (){
                    setState(() {
                      _aadhar.text.isEmpty?_validate1=true:_validate1=false;
                      _register.text.isEmpty?_validate2=true:_validate2=false;

                    });
                    if(_validate1==false && _validate2==false){

//                      setState(() async {
//                        var databasesPath = await getDatabasesPath();
//                        String path = p.join(databasesPath, 'demo.db');
//                        var db = await openDatabase(path);
//
//
//                        await db.transaction((txn) async {
//                        int id1 = await txn.rawInsert('INSERT (Name, Aadhar, Email, Contact, Address) VALUES(_name, _aadhar, _email, _num, _add)');
//                        print(id1);
//                        });
//                        await db.close();
//                      });
                      Flushbar(
                        message: "Your Details will be Verified soon",
                        icon: Icon(
                          Icons.verified_user,
                          size: 20.0,
                          color: Colors.green[800],
                        ),
                        duration: Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.green[700],
                      )..show(context);

                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          Navigator.pushNamed(context, otp.id);
                        });
                      });
                    }
                  },
                    child: Text('Verify',style: TextStyle(fontSize: 20.0),),color: Colors.orangeAccent,elevation: 7.0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38.0),),),
                ),
              ],
            ),
          ),
        ),
    );
  }
}