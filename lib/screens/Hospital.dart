import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:hospital_portal/screens/Homepage.dart';
import 'package:hospital_portal/screens/Verification.dart';
import 'package:hospital_portal/screens/Registration.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:path/path.dart' as p;

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

Container HospitalList({String txt}){
  return Container(margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(border: Border(
      bottom: BorderSide( //                   <--- left side
        color: Colors.blueGrey,
        width: 3.0,
      ),),),
    child: Text(txt,style: TextStyle(fontSize: 18.0),),);
}

class Hospital extends StatefulWidget {
  static const String id = 'hospital';
  @override
  _HospitalState createState() => _HospitalState();
}

@override
Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  if (search == "empty") return [];
  if (search == "error") throw Error();
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description :$search $index",
    );
  });
}

class _HospitalState extends  State<Hospital>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Hospital'),actions: <Widget>[

    ],
    ),
        drawer: Drawer(child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF01579B),
              ),
              child: Text(
                'Hospital',
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
              leading: Icon(Icons.verified_user),
              title: Text('Verification'),
              onTap: () {
                Navigator.pushNamed(context, Verification.id);
              },
            ),

          ],
        ),),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200.0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBar<Post>(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  hintText: "Enter your Name here..",
                  hintStyle: TextStyle(
                    color: Colors.grey[100],
                  ),
                  debounceDuration: Duration(milliseconds: 800),
                  minimumChars: 5,
                  crossAxisCount: 2,
                  indexedScaledTileBuilder: (int index) => ScaledTile.count(
                    index % 3 == 0 ? 2 : 1,
                    1,
                  ),
                  cancellationWidget: Text("ok"),
                  loader: Center(child: Text('Loading.....')),
                  searchBarStyle: SearchBarStyle(
                    backgroundColor: Colors.white70,
                    padding: EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onSearch: search,
                  onItemFound: (Post post, int index) {
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.description),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox( height: 10.0,),
          Text('List of Hospitals Available',style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
          SizedBox( height: 10.0,),
          Container(margin: EdgeInsets.all(15.0),
            height: 200.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
            child: ListView(children: <Widget>[

              HospitalList(txt: "💉     AMRI Hospital, Dhakuria"),
              HospitalList(txt: "💉     Peerless Hospital "),
              HospitalList(txt: "💉     Fortis Hospital "),
              HospitalList(txt: "💉     Woodlands "),
              HospitalList(txt: "💉     Ruby General Hospital "),
              HospitalList(txt: "💉     Command Hospital "),


          ],
          ),
            
          ),
        ],
      ),

    );
  }
}