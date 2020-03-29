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
    get_request_data_from_SharedPreferences1();
  }

  List data = new List();
  void get_request_data_from_SharedPreferences() async {
    database().get_request1().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
    //data.removeLast();
  }

  List data1 = new List();
  void get_request_data_from_SharedPreferences1() async {
    database().get_request13().then((result) {
      setState(() {
        data1.addAll(result);
      });
    });
  }

  Widget oo1(int id) {
    return ListView.builder(
      itemCount: data1.length,
      itemBuilder: (context, index1) {
        if ("$id" == data1[index1]['examid']) {
          return Card(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
              child: Column(
                children: <Widget>[
                  Text("ffffffffff id :${data1[index1]["examid"]}"),
                  Text("chapter id :${data1[index1]["chapter"]}"),
                  Text("type id :${data1[index1]["type"]}"),
                  Text("level id :${data1[index1]["level"]}"),
                  Text("count id :${data1[index1]["count"]}"),
                ],
              ));
        }
      },
    );
  }

  Widget oo() {
    data.reversed;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
            //height: 100,
            //margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
            child: Column(
          children: <Widget>[
            Text("exam id :${data[index]['Nationalid']}"),
            Text("subjectname:${data[index]['password']}"),
            Text("when start is:${data[index]['whenstart']}"),
            Text("How long :${data[index]["time"]}"),
            Text("datadatadatadatadatadatadata"),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: data1.length,
                itemBuilder: (context, index1) {
                  if (data1[index1]['examid'] == data[index]['ID']) {
                    return Card(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 15),
                        child: Column(
                          children: <Widget>[
                            Text("ffffffffff id :${data1[index1]["examid"]}"),
                            Text("chapter id :${data1[index1]["chapter"]}"),
                            Text("type id :${data1[index1]["type"]}"),
                            Text("level id :${data1[index1]["level"]}"),
                            Text("count id :${data1[index1]["count"]}"),
                          ],
                        ));
                  } else {
                    return Container();
                  }
                },
              ),
            )

            /*Row(
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
            )*/
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
