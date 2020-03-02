import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/Database.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toast/toast.dart' as Toast;

class request extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return requestpage();
  }
}

class requestpage extends State<request> {
  List data = new List();
  void hh() async {
    database().get_request().then((result) {
      setState(() {
        data.addAll(result);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    hh();
  }

  Widget oo() {
    print("fffffffffffffffff${data}");
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Text("${data[index]['realName']}"),
            Text("${data[index]['Nationalid']}"),
            Text("${data[index]['Email']}"),
            FlatButton(
              onPressed: () {
                database().accept(
                    data[index]['Nationalid'],
                    data[index]['Email'],
                    data[index]['realName'],
                    data[index]['Password'],
                    data[index]['ID']);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => request()));
              },
              child: Text("accept"),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {},
              child: Text("reject"),
              color: Colors.blue,
            ),
          ],
        );
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
              //    flex: 1,
            ),
          ],
        )),
      ),
    );
  }
}
