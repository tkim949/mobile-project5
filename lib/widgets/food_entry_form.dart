import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../models/food_entry.dart';
import 'package:location/location.dart';

import 'dart:async';

enum AnalyticsEventType {
  food_post,
}

class Analytics {
  static String _eventType;
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static Future analyticsLogEvent(AnalyticsEventType eventType, Map<String, dynamic> paramMap) async {
    _eventType = await _enumToString(eventType);
    await analytics.logEvent(
      name: _eventType,
      parameters: paramMap,);
  }
  static Future _enumToString(eventType) async{
    return eventType.toString().split('.')[1];
  }
}


class FoodEntryForm extends StatefulWidget {
  final File image;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  FoodEntryForm({Key key, this.analytics, this.observer, this.image}) : super(key: key);
  @override
  _FoodEntryFormState createState() => _FoodEntryFormState(analytics, observer);
}

class _FoodEntryFormState extends State<FoodEntryForm> {
  _FoodEntryFormState(this.analytics, this.observer);
 //File image;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  //final File image;


  final formKey = GlobalKey<FormState>();
 // var num;
  Food newfood = Food();
  //File img;
  //String url;
  LocationData locationData;
  
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }

  Future logPostCreated() async{
    await analytics.logEvent(name: 'create_post');

  }

  Widget enterNumber() {
    //addDate();
    return Semantics(
      label: "Number of waste food",
      enabled: true,
      textField: true,
      onTapHint: "number only with numeric keyboard",
      child:TextFormField(
        key: Key('userNumInput'),
        autofocus: true,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: paddings(context)*0.8),
        decoration: new InputDecoration(hintText: "Number of Waste Item.", alignLabelWithHint: true),
        //textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number, //service
        /*inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
          ],*/

        validator: (value) {
          var intValue = int.tryParse(value);
          if(intValue == null || intValue < 1) {
            return 'Please enter a correct number';
           
          } else{
            return null;
          }
        },
        onSaved: (value) {
          //num = int.parse(value);
          
          newfood.quantity = int.tryParse(value);
        },
        )
   );

  }

  Future getImageRef(String name) async{
    
    try {
      
      StorageReference storageReference =
      FirebaseStorage.instance.ref().child(name);
      StorageUploadTask uploadTask = storageReference.putFile(widget.image); //widget.image
      uploadTask.onComplete.then((onValue) async {
      String url = (await storageReference.getDownloadURL()).toString();
      //print(url);
      newfood.imageURL = url;
      //print(newfood.imageURL);
      });
       
    } catch(error){
      print(error);
    }    
  }
  

  void addDate() async {
    //newfood.date = new Timestamp.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    newfood.date = Timestamp.fromDate(new DateTime.now());
    newfood.latitude = locationData.latitude;
    newfood.longitude = locationData.longitude;
    //await getImageRef(newfood.date.toDate().toString());
  }

  Widget uploadButton(BuildContext context) {
     return FutureBuilder(
           future: getImageRef(newfood.date.toDate().toString()),
           builder: (context, snapshot) { 
           return Expanded(
                 child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      //border: Border.all(width: paddings(context)*2, color:Colors.blue)
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Semantics(
                        label: 'Upload button',
                        enabled: true,
                        button: true,
                        onTapHint: 'Enables to upload a new post into firestore data and storage',
                        child:RaisedButton(
                          child: Icon(Icons.cloud_upload, size:paddings(context)*2),
                                        
                          onPressed: (){
                            if(formKey.currentState.validate()) {
                                formKey.currentState.save();
                                  //addDate();
                                Firestore.instance.collection('posts').add(newfood.toMap());
                                //logPostCreated();
                                //_analyticsParameter = {'post_upload': 1};
                                Analytics.analyticsLogEvent(AnalyticsEventType.food_post, {'post_upload': 1});
                                Navigator.of(context).pop();
                            }
                          },
                      ),
                   ),
                  ),
                ),
              );
           }
    
        );
     }


  @override
  Widget build(BuildContext context) {
    addDate();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Waste Food'),
        centerTitle: true,
        ),

      body: 
           Padding(
              padding: EdgeInsets.all(paddings(context)*0.1),
              child: Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                  //Text("place for photo"),
                  //CircularProgressIndicator(value: 1.0),
                  Center(child: 
                       Semantics(
                        label: 'Food Image',
                        //image: true,
                        child: (widget.image == null) ? 
                          CircularProgressIndicator() :
                          Image.file(widget.image, height: paddings(context)*7, width: paddings(context)*9, fit:BoxFit.fill),),),
                      
                          //Image.network(newfood.imageURL, height:paddings(context)*7, width: paddings(context)*9, fit:BoxFit.fill),),),
                  //loadImgURL(context);
                  
                  SizedBox(height: paddings(context)*0.5),
                  enterNumber(),
                  SizedBox(height: paddings(context)*5),
                  uploadButton(context),
        
          ],),
         ),

      ),
      
    );
  }
  /*Try to use loading builder with image.Network for circular progree indicator.
    But, as far as I know, it needs url, not file. 
    Then, at this point, the app has only image file from image picker because no one would want to store file in the storage before uploading.
    I couldn't find the url of the file that is just picked with image picker.
    Also, the circular progress indicator at this point is not required so I didn't choose using loading builder.
  */
  Widget loadImgURL(BuildContext context) {
    return 
         FutureBuilder(
              future: getImageRef(newfood.date.toDate().toString()),
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return 
                        Image.network(newfood.imageURL, height: paddings(context)*7, width: paddings(context)*9, fit:BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                                        ImageChunkEvent loadingProgress) {
                                  if(loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                         ? loadingProgress.cumulativeBytesLoaded /loadingProgress.expectedTotalBytes
                                         : null,
                                    ),
                                  );
                            } 
                          ); //),

                        }
                        else {
                          return Center(child: CircularProgressIndicator());
                        } 
                  }
            );
      }

}
double paddings(BuildContext context) {
  if(MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * 0.05;
  } else {
    return MediaQuery.of(context).size.width * 0.1;
  }
}