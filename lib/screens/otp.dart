import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:flushbar/flushbar.dart';
import 'package:hospital_portal/screens/After_verif.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:hospital_portal/screens/Registration.dart';



class otp extends StatefulWidget{
  static const String id = 'otp';


  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<otp>{
  FlutterOtp otp = FlutterOtp();
  int _otp;
  String _notp;
  final FocusNode _focus1 = new FocusNode();
  final FocusNode _focus2 = new FocusNode();
  final FocusNode _focus3 = new FocusNode();
  final FocusNode _focus4 = new FocusNode();
  final FocusNode _focus5 = new FocusNode();
  final FocusNode _focus6 = new FocusNode();






  @override
  void initState() {

    String phno = '9002342503';// value received from sql server
    _otp = 100000 + Random().nextInt(799999 - 10000);
    print(_otp);
    String mssg = "Your OTP is : $_otp";
    otp.sendOtp(phno,mssg,100000,999999,'+91');
    super.initState();
  }

  @override
  Widget Result(String newOTP){
    print(newOTP);
    if(newOTP == _otp.toString()){
      print('Success');
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => new After_verif(),));

    }
    else{print('Failure');

    return Flushbar(
      message: "Check the OTP and re-enter",
      icon: Icon(
        Icons.info,
        size: 20.0,
        color: Colors.blue[500],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[200],
    )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Screen'),centerTitle:true,leading: Container(),),

      body: Center(child: Container(
        padding: EdgeInsets.all(8.0),
        height: 450.0,
        width: 350.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(27.0),color: Colors.black12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enter OTP Here',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500,),),

              SizedBox(height: 20.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 20.0,),
                  Container(
                      height: 50,
                      width: 30,
                      child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                        _notp = val;
                      },textInputAction: TextInputAction.next,focusNode: _focus1,onSubmitted: (term){
                        _focus1.unfocus();
                        FocusScope.of(context).requestFocus(_focus2);
                      },
                      )
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                      height: 50,
                      width: 30,
                      child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                        _notp += val;
                      },textInputAction: TextInputAction.next,focusNode: _focus2,onSubmitted: (term){
                        _focus2.unfocus();
                        FocusScope.of(context).requestFocus(_focus3);
                      },)
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                      height: 50,
                      width: 30,
                      child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                        _notp += val;
                      },textInputAction: TextInputAction.next,focusNode: _focus3,onSubmitted: (term){
                        _focus3.unfocus();
                        FocusScope.of(context).requestFocus(_focus4);
                      },)
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                      height: 50,
                      width: 30,
                      child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                        _notp += val;
                      },textInputAction: TextInputAction.next,focusNode: _focus4,onSubmitted: (term){
                        _focus4.unfocus();
                        FocusScope.of(context).requestFocus(_focus5);
                      },)
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                      height: 50,
                      width: 30,
                      child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                        _notp += val;
                      },textInputAction: TextInputAction.next,focusNode: _focus5,onSubmitted: (term){
                        _focus5.unfocus();
                        FocusScope.of(context).requestFocus(_focus6);
                      },)
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    height: 50,
                    width: 30,
                    child: TextField(style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,maxLength:1,keyboardType: TextInputType.number,onChanged: (val){
                      _notp += val;
                    },focusNode: _focus6,
                    ),),
                  SizedBox(
                    width: 20.0,
                  ),

                ],
              ),

              SizedBox(height: 38.0,),

              RaisedButton(onPressed: (){
                setState(() {
                  Result(_notp);
                });
              },
                child: Text('Done',style: TextStyle(fontSize: 20.0,),),color: Colors.green,elevation: 7.0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38.0),),),

            ],
          ),
        ),
      ),),
    );
  }
}

