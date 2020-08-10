import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../models/food_entry.dart';
import 'package:location/location.dart';


class FoodEntryForm extends StatefulWidget {
  final File image;
  FoodEntryForm({Key key, this.image}) : super(key: key);
  @override
  _FoodEntryFormState createState() => _FoodEntryFormState();
}

class _FoodEntryFormState extends State<FoodEntryForm> {

  final formKey = GlobalKey<FormState>();
  var num;
  Food newfood = Food();
  File img;
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

  Widget enterNumber() {
    addDate();
    return Semantics(
      label: "Number of waste food",
      enabled: true,
      textField: true,
      hint: "number only with numeric keyboard",
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
          if(intValue == null) {
            return 'Please enter a number';
           
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
    //String url='';
    try {
      
      StorageReference storageReference =
      FirebaseStorage.instance.ref().child(name);
      StorageUploadTask uploadTask = storageReference.putFile(widget.image);
      uploadTask.onComplete.then((onValue) async {
      String url = (await storageReference.getDownloadURL()).toString();
      print(url);
      newfood.imageURL = url;
      print(newfood.imageURL);
      });
      /*await storageReference.putFile(widget.image).onComplete.catchError((onError){
        print(onError);
        return false;
      });
      url = (await storageReference.getDownloadURL()).toString();*/
      
    } catch(error){
      print(error);
    }
      //url = downurl.toString();
      //newfood.imageURL = url.toString();
      //addURL(url);
      
      /*
      StorageReference storageReference =
        FirebaseStorage.instance.ref().child('EXAMPLE2.jpg');
      StorageUploadTask uploadTask = storageReference.putFile(widget.image);
      await uploadTask.onComplete;
      url = await storageReference.getDownloadURL(); */
      //newfood.imageURL = url;
   
  }
  /*
  void addURL(String url) {
    if(url != null) {
     newfood.imageURL = url;
    }
  }*/

  void addDate() async {
    //newfood.date = new Timestamp.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    newfood.date = Timestamp.fromDate(new DateTime.now());
    //newfood.date = new DateTime.now().toString();
    newfood.latitude = locationData.latitude;
    newfood.longitude = locationData.longitude;
    //getImageRef(newfood.date.toDate().toString());
    //newfood.imageURL = url;
    //print(newfood.imageURL);
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
                        hint: 'Enables to upload a new post into firestore data and storage',
                        child:RaisedButton(
                          child: Icon(Icons.cloud_upload, size:paddings(context)*2),
                                        
                          onPressed: (){
                            if(formKey.currentState.validate()) {
                                formKey.currentState.save();
                                  //addDate();
                                Firestore.instance.collection('posts').add(newfood.toMap());

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
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Waste Food'),
        centerTitle: true,
        ),

      body: Padding(
              padding: EdgeInsets.all(paddings(context)*0.1),
              child: Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                  //Text("place for photo"),
                  Center(child: (widget.image == null) ? 
                    CircularProgressIndicator() :
                    Image.file(widget.image, height: paddings(context)*7, width: paddings(context)*9, fit:BoxFit.fill),),
                  SizedBox(height: paddings(context)*0.5),
                  enterNumber(),
                  SizedBox(height: paddings(context)*5),
                  uploadButton(context),
         /*FutureBuilder(
           future: getImageRef(newfood.date.toDate().toString()),
           builder: (context, snapshot) {
           return Align(
                  alignment: Alignment.bottomCenter,
                  child:uploadButton(context));},
         ),*/
        ],),
      
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Padding(
        padding: EdgeInsets.all(5),
        child: addUploadFab(context),
        )*/
      )
     ),
     /*bottomNavigationBar: BottomAppBar(
       shape: CircularNotchedRectangle(),
       notchMargin: paddings(context)* 3,
       //primaryColor: Colors.blue,
       child: Icon(Icons.cloud_upload, size: 20),
             //uploadButton(context),
     ),*/
    );
  }

  
/*
  FloatingActionButton addUploadFab(BuildContext context) {
    return FloatingActionButton(
        
        onPressed: (){
          if(formKey.currentState.validate()) {
            formKey.currentState.save();
            addDate();
            Firestore.instance.collection('posts').add(newfood.toMap());
            Navigator.of(context).pop();
            }
          //else {
          //  Text("Number input needed!");
         // }
        },
        child: Padding(
                padding: EdgeInsets.all(4),
                  child: Icon(Icons.cloud_upload, size: 50),
                  ),
           

          
          
            /*
            {
            'date': Timestamp.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
            'imageURL': 'testforURLfromapp',
            'quantity': num,
            'latitude': 1,
            'longitude': 2,
          }*/
          );
  } */

}
double paddings(BuildContext context) {
  if(MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * 0.05;
  } else {
    return MediaQuery.of(context).size.width * 0.1;
  }
}