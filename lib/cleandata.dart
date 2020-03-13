import 'package:exam/Database/Database_professor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Database/Database_admin.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class clean extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return cleanpage();
  }
}

class cleanpage extends State<clean> {
  void initState() {
    super.initState();
    get_request_data_from_SharedPreferences();
  }

  List data = new List();
  void get_request_data_from_SharedPreferences() async {
    database().get_request1().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  Widget oo() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
            child: Column(
              children: <Widget>[
                Text("subjectname:${data[index]['Question']}"),
                Text("chaptername is:${data[index]['subject']}"),
                Text("Email:${data[index]['numberofchapter']}"),
                Text("National ID:${data[index]['bank']}"),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          database().get_request12(data[index]['ID']);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => clean()));
                        },
                        icon: Icon(Icons.clear),
                        color: Colors.blue,
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: oo(),
            ),
//            get_the_admin_data(),
          ],
        )),

/*         Container(
          child: Expanded(child: oo()),
        ),*/
      ),
    );
  }
}
