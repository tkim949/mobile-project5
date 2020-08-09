import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/food_entry_s.dart';


class FoodCamera extends StatefulWidget {

  static const routeName = "camera";

  @override
  _FoodCameraState createState() => _FoodCameraState();
}

class _FoodCameraState extends State<FoodCamera> {

  File image;
  final _picker = ImagePicker();
  PickedFile imageFile;
  
  void _getLocalImage() async {
    //image = await ImagePicker.pickImage(source: ImageSource.gallery)
    imageFile = await _picker.getImage(source: ImageSource.gallery); 
    image = File(imageFile.path);
    setState( () {} );
  }

  //final File file = File(image.path); //only static member can....!
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
           title: Text("Camera")),
        body: Center(
          child: isLocate()),
          /*
          if (image == null) {
            return //Center(child:
              RaisedButton(
                child: Text('Select Photo'),
                onPressed: () {
                  _getLocalImage();
                }
                
            // )
            
            ,);
          } else {
            return //Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.file(image),
                  SizedBox(height: 40),
                  RaisedButton(
                    child: Text('Post it!'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(FoodEntryS.routeName);
                    })
                ],
              
              // ),
                
            ); */
         );

  }

  Widget isLocate() {
    if (image == null) {
            return //Center(child:
              RaisedButton(
                child: Text('Select Photo'),
                onPressed: () {
                  _getLocalImage();
                },
            );
          } else {
            return //Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.file(image),
                  SizedBox(height: 5),
                  RaisedButton(
                    child: Text('Post it!'),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(FoodEntryS.routeName);
                    })
                ],    
            );
          }

  }
}