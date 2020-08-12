import 'package:flutter/material.dart';
//import '../models/food_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class FoodDetailS extends StatelessWidget {
  static const routeName ="food_detail";
  //static FoodEntry fE;
  
  Widget build(BuildContext context) {
    //throw new StateError("New Error");
    //fE = ModalRoute.of(context).settings.arguments;
    DocumentSnapshot post = ModalRoute.of(context).settings.arguments;
    //FoodEntry fE = post as FoodEntry; //.toObject(FoodEntry.class);//getValue();
    //  FoodEntry fE = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        
         resizeToAvoidBottomInset: false,
         appBar: AppBar(
            title: Text("Food Detail Screen"),
            centerTitle: true,
           ),
        body:  
            //Center(
            // child: Text("Here for a detailed info of the chosen item."),) 
            Padding(
                padding: EdgeInsets.all(paddings(context)*0.5),
                child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,  
                    children: //<Widget>[],
                    [
                      //Text(post['date'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: paddings(context)*0.5)),
                      //Text(post['date'].toDate().toString()),
                      Text(DateFormat('EEE, MMMM d, y').format(post['date'].toDate()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: paddings(context)*0.8)),
                      SizedBox(height: paddings(context)*0.5),
                      Semantics(
                        child: Image.network(post['imageURL'],height:paddings(context)*7, width: paddings(context)*9, fit:BoxFit.fill),
                        label: 'Detail food image',
                      ),
                      SizedBox(height: paddings(context)*3),
                      Text('${post['quantity'].toString()} Item',
                           textAlign: TextAlign.center,
                          style: TextStyle( fontSize: paddings(context))),
                      SizedBox(height: paddings(context)*2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Location (${post['latitude'].toString()},  '),
                          //SizedBox(width: paddings(context)*0.5),
                          Text('${post['longitude'].toString()})'),
                      ],),   
                     // Text(post['imageURL']),
              ],
            ),
                 
          ),
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