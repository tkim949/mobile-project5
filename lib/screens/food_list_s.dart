import 'dart:io';
import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/food_entry_s.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/food_detail_s.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';


class FoodListS extends StatefulWidget {

  FoodListS({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  static const routeName = 'list_screen';

  @override
  _FoodListSState createState() => _FoodListSState(analytics, observer);
}

class _FoodListSState extends State<FoodListS> {
  _FoodListSState(this.analytics, this.observer);
  //FoodEntry foodE;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  File image;
  final _picker = ImagePicker();
  PickedFile imageFile;
  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  /*
  bool _isLoading = true;
  void _submit() {
    //setState(() {
    //  _isLoading = true;
    //});
    new Future.delayed(new Duration(seconds: 4), () {
      setState( () {
        _isLoading = false;
      });
    });
  } */

  /* Pick an image from the gallery */
  //void _getLocalImage() async {
  Future<void> _getLocalImage(BuildContext context) async {
    //image = await ImagePicker.pickImage(source: ImageSource.gallery)
    
    imageFile = await _picker.getImage(source: ImageSource.gallery); 
    //File select = File(imageFile.path);
    print(imageFile);
    if(imageFile != null) {
    image = File(imageFile.path);
    print(image);
    
    Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image,);
    /*Navigator.push(context, 
                   MaterialPageRoute(
                     builder: (context) => FoodEntryS(analytics: analytics,
                                          observer: observer, image: image),
                     settings: RouteSettings(name: FoodEntryS.routeName),),);*/                 
    _clear();
    }
    else {
      print("No pick");
    }
    setState( () {
      //image = select;
    } );  
  }
 
  void _clear() {
    setState(() => image = null);
  }
 /*Extra credit 
 https://stackoverflow.comm/questions/52729497/
 */
  int total = 0;
  void getNum() {
    Firestore.instance.collection('posts').snapshots().listen((snapshot) {
      int tempTot = snapshot.documents.fold(0, (tot, doc) =>
        tot + doc.data['quantity']);
      setState(() {total = tempTot;});
      //print('Total: $total');
    });
  }

  Widget build(BuildContext context) {
    //throw new StateError("New Error");
    getNum();  //Extra credit
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: 
              Column(
              children: [
                Text("Food List Screen"),
                Text('Total items: $total', style: TextStyle(fontSize: paddings(context)*0.4)),
             ],),
            centerTitle: true,
         ),
        body: //Center(child: Timer(const Duration(milliseconds: 1000), () => 
             bodyStream(context),
          
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: newEntryFab(context),
          label: 'Get image Button',
          button: true,
          enabled: true,
          onTapHint: 'Click to get device photos',   
        ),
    );
  }

/* Widget for Streambuilder that shows the list */
  Widget bodyStream(BuildContext context) { 
    return StreamBuilder(         
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (content, snapshot) {
             
          if(snapshot.hasData && snapshot.data.documents != null 
                   && snapshot.data.documents.length >0) {
            return Column(
              children: <Widget>
                [ Expanded(
                  child: ListView.builder(
                    key: Key('list'),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data.documents[index];
                      if(post != null) {
                        return ListTile(
                          title: Row(
                          children: <Widget>[
                            Expanded(child:Text(DateFormat('EEEE,').format(post['date'].toDate())),),
                            Expanded(child: Text(DateFormat('MMMM d,').format(post['date'].toDate())),),
                            Expanded(child: Text(DateFormat('y').format(post['date'].toDate())),),
                            Expanded(child: Text(post['quantity'].toString(), textAlign: TextAlign.right,),),
                              ],),
                               
                          onTap: () {
                                //throw new StateError("New Error");
                            Navigator.of(context).pushNamed(FoodDetailS.routeName, arguments:post);
                            }    
                           );
                      }
                      return Center(child: CircularProgressIndicator());  
                      
                },),)

            ],);  
          } 
          else{
             return Center(child: CircularProgressIndicator(),);
          }
       }   
    );
  }
  /*
  Widget keepPI(BuildContext context) {
    while(isLoading) {
    return CircularProgressIndicator(); }
    return CircularProgressIndicator();
  }*/

  /* Button to go to the gallery to pick an image */

  FloatingActionButton newEntryFab(BuildContext context){
      if(image == null) {
        return FloatingActionButton( 
              onPressed: () {   
               
                _getLocalImage(context);
                
              },
              child: Icon(Icons.photo_camera),  );
      } else {
        return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                _clear();
              },
              child: Icon(Icons.photo_camera),  );
      }                        
  }
}

double paddings(BuildContext context) {
  if(MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * 0.05;
  } else {
    return MediaQuery.of(context).size.width * 0.1;
  }
}