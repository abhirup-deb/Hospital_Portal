import 'package:flutter/material.dart';
import 'package:hospital_portal/screens/Homepage.dart';
import 'package:hospital_portal/screens/Verification.dart';
import 'package:hospital_portal/screens/Hospital.dart';
import 'package:flushbar/flushbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;


class Registration extends StatefulWidget {
  static const String id = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends  State<Registration>{
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool digit = false;
  final _name = TextEditingController();
  final _aadhar = TextEditingController();
  final _email = TextEditingController();
  final _num = TextEditingController();
  final _add = TextEditingController();



  @override
  void dispose() {
    _name.dispose();
    _aadhar.dispose();
    _email.dispose();
    _num.dispose();
    _add.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Registration'),centerTitle: true,
        ),
        drawer: Drawer(child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF01579B),
              ),
              child: Text(
                'Register',
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
              leading: Icon(Icons.verified_user),
              title: Text('Verification'),
              onTap: () {
                Navigator.pushNamed(context, Verification.id);
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
          width: 350.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(27.0),color: Colors.black12),
          child: ListView(
            children: <Widget>[
              Container(height: 70.0,width:240.0,
                  child: TextField(style: TextStyle(color: Colors.white70),controller: _name,textAlign: TextAlign.center,decoration: InputDecoration(
                    hintText: 'Enter Your Name',hintStyle: TextStyle(color: Colors.blueGrey,),errorText: _validate1?"Please Fill up this Field":null,
                  ),)),

              SizedBox(
                height: 3.0,
              ),
              Container(height: 70.0,width:240.0,
                  child: TextField(style: TextStyle(color: Colors.white70),controller:_aadhar,textAlign: TextAlign.center,decoration: InputDecoration(
                    hintText: 'Enter Your Aadhar No.',hintStyle: TextStyle(color: Colors.blueGrey,),errorText: _validate2?"Please Fill up this Field":null,
                  ),)),
              SizedBox(
                height: 3.0,
              ),
              Container(height: 70.0,width:240.0,
                  child: TextField(style: TextStyle(color: Colors.white70),controller: _email,keyboardType: TextInputType.emailAddress,textAlign: TextAlign.center,decoration: InputDecoration(
                    hintText: 'Enter Your Email',hintStyle: TextStyle(color: Colors.blueGrey),
                  ),)),
              SizedBox(
                height: 3.0,
              ),
              Container(height: 70.0,width:240.0,
                  child: TextField(style: TextStyle(color: Colors.white70),maxLength:10,controller: _num,textAlign: TextAlign.center,keyboardType: TextInputType.number,decoration: InputDecoration(
                    hintText: 'Enter Your 10 digit Contact Number',hintStyle: TextStyle(color: Colors.blueGrey,),errorText: _validate3?"Please Fill up this Field":null,
                  ),)),
              SizedBox(
                height: 3.0,
              ),
              Container(height: 70.0,width:240.0,
                  child: TextField(style: TextStyle(color: Colors.white70),controller: _add,textAlign: TextAlign.center,decoration: InputDecoration(
                      hintText: 'Enter Your Current Address',hintStyle: TextStyle(color: Colors.blueGrey)
                  ),)),
              SizedBox(
                height: 3.0,
              ),

              SizedBox(height: 4.0,),
              Center(
                child: RaisedButton(onPressed: (){
                  setState(() {
                    _name.text.isEmpty?_validate1=true:_validate1=false;
                    _aadhar.text.isEmpty?_validate2=true:_validate2=false;
                    _num.text.isEmpty?_validate3=true:_validate3=false;
                    if(_num.text.length==10){
                      digit = true;
                    }
                    else{
                      Flushbar(
                        message: "Enter a 10 digit Contact Number",
                        icon: Icon(
                          Icons.info,
                          size: 20.0,
                          color: Colors.red[500],
                        ),
                        duration: Duration(seconds: 5),
                        leftBarIndicatorColor: Colors.red[200],
                      )..show(context);
                    }
                  });
                  if(_validate1==false && _validate2==false && _validate3==false && digit==true){
                    setState(()async {
                      var databasesPath = await getDatabasesPath();
                      String path = p.join(databasesPath, 'demo.db');
                      var db = await openDatabase(path);


                      await db.transaction((txn) async {
                        int id1 = await txn.rawInsert('INSERT (Name, Aadhar, Email, Contact, Address) VALUES(_name, _aadhar, _email, _num, _add)');
                        print(id1);
                      });
                      await db.close();
                    });


                    Flushbar(
                      message: "Registered Successfully",
                      icon: Icon(
                        Icons.event_available,
                        size: 20.0,
                        color: Colors.green[800],
                      ),
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.green[700],
                    )..show(context);

                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        Navigator.pushNamed(context, Homepage.id);
                      });
                    });
                  }
                },
                  child: Text('Register',style: TextStyle(fontSize: 20.0),),color: Colors.teal,elevation: 7.0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38.0),),),
              ),
            ],
          ),
        ),
    ),
    );
  }
}