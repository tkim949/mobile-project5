import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //for the orientation

import 'app.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();

   SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown

  ]);
  runApp(App());
}
/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotePage(),
    );
  }
}

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fire Notes')),
      body: _createBody(),
    );
  }
}

Widget _createBody() {
  return StreamBuilder(
   stream: Firestore.instance
   .collection('notes').document('example').snapshots(),
   builder: (context, snapshot) {
     if (snapshot.hasData) {
        var doc = snapshot.data;
        if(doc.exists) {
          return Text(doc['content']);
        }
     }
     return CircularProgressIndicator();
   }

  );
} */
  