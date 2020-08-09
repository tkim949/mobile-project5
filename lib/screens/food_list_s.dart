import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/food_entry_s.dart';
//import '../screens/food_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/food_detail_s.dart';
//import '../models/food_entry.dart';
//import 'package:timeago/timeago.dart';
import 'package:intl/intl.dart';

class FoodListS extends StatefulWidget {
  static const routeName = 'food_list';

  @override
  _FoodListSState createState() => _FoodListSState();
}

class _FoodListSState extends State<FoodListS> {
  //FoodEntry foodE;

  File image;
  final _picker = ImagePicker();
  PickedFile imageFile;
  
  //void _getLocalImage() async {
  Future<void> _getLocalImage() async {
    //image = await ImagePicker.pickImage(source: ImageSource.gallery)
    imageFile = await _picker.getImage(source: ImageSource.gallery); 
    File select = File(imageFile.path);
    setState( () {
      image = select;
    } );
    Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
    _clear();
  }
 
  void _clear() {
    setState(() => image = null);
  }
  /*
  Widget pickPhoto() {
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

  } */
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
    getNum();
    return Scaffold(
         appBar: AppBar(
            title: 
              Column(
              children: [Text("Food List Screen"),
                        Text('Total items: $total', style: TextStyle(fontSize: paddings(context)*0.4)),
             ],),
            centerTitle: true,
         ),
        body: //Center(
          //child: Text("Here for the food list"),),
          StreamBuilder(
            stream: Firestore.instance.collection('posts').snapshots(),
            builder: (content, snapshot) {
              if(snapshot.hasData) {
                return Column(
                  children: <Widget>
                  [ Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data.documents[index];
                        if(post != null) {
                        return ListTile(
                          //title: Text(timeago.format(DateTime.tryparse(post['date'].toDate().toString())).toString()),
                           title: Row(
                             children: <Widget>[
                               Expanded(child:Text(DateFormat('EEEE, MMMM d, y').format(post['date'].toDate())),),
                               //Expanded(child: Text(DateFormat.yMMMMd().format(post['date'].toDate())),),
                               //Expanded(child: SizedBox(width: paddings(context)*0.09)),
                               Expanded(child: Text(post['quantity'].toString(), textAlign: TextAlign.right,),),
                               ],),
                          //title: Text(DateTime.fromMicrosecondsSinceEpoch(post['date'].microsecondsSinceEpoch).toString()),
                          //subtitle: Text(post['quantity'].toString()),
                          
                          onTap: () {
                            
                            Navigator.of(context).pushNamed(FoodDetailS.routeName, arguments:post);}
                          
                        );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }
                      },),)

                  ],);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
            ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: newEntryFab(context),
        /*floatingActionButton: FutureBuilder(
                           future:   _getLocalImage(),
                           builder: (context, snapshot) {
                           if(snapshot.data != null){
                               return newEntryFab(context); }
                           else {
                               return CircularProgressIndicator();
                           }}, ),*/

        );

  }

  FloatingActionButton newEntryFab(BuildContext context){
    /*
    return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                _clear();
              },
              child: Icon(Icons.photo_camera),  ); */

    
      if(image == null) {
        return FloatingActionButton( 
              onPressed: () { 
                _getLocalImage();
                /*
                if(image != null) {
                  return Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                }
                else {
                  return CircularProgressIndicator();
                }*/
                //if(image == null) {CircularProgressIndicator();}
                //Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                //_clear();
                
              },
              
              child: Icon(Icons.photo_camera),  );
      }else{
        return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                _clear();
              },
              child: Icon(Icons.photo_camera),  );

      } 
      /*
        return FloatingActionButton(
           
              onPressed: () //=> pushNewEntry(context),
              { 
                //RaisedButton(
                //onPressed: () {
                  if(image == null) {
                    _getLocalImage();
                  }
                  try {
                    Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);
                  } catch(error){
                    print(error);
                    CircularProgressIndicator();
                  }
                  _clear();
                },
                child: Icon(Icons.photo_camera),  
          ); */
        
                   /*
                    if(image == null) {
                    _getLocalImage(); 
                    
                    RaisedButton(
                      onPressed: () {
                        if(image != null) {
                            return  Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image);}
                        else { return Center(child: CircularProgressIndicator());

                        }
                      } 
                      );
                    } */
                /*
                if(image == null){
                  return Center(child: CircularProgressIndicator()); }
                else{
                
                Navigator.of(context).pushNamed(FoodEntryS.routeName, arguments:image); }
                //pushNewEntry(context); */
                //_clear();
                         
  }

/*
  void pushNewEntry(BuildContext context) {
    Navigator.of(context).pushNamed(FoodEntryS.routeName);
  }*/

}
double paddings(BuildContext context) {
  if(MediaQuery.of(context).orientation == Orientation.landscape) {
    return MediaQuery.of(context).size.width * 0.05;
  } else {
    return MediaQuery.of(context).size.width * 0.1;
  }
}