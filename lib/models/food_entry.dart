import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  //String id;
  //String date;
  Timestamp date;
  //String date;
  double latitude;
  double longitude;
  String imageURL;
  int quantity;
  
  Food({this.date, this.latitude, this.longitude, this.imageURL, this.quantity});
  //Food();
  /*
  Food.nullEntry():
  id='', date=Timestamp.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch), 
  latitude=0, longitude=0, imageURL ='', quantity=0; */
  
  Food.fromMap(Map<String, dynamic> data) {
    //id = data['id'];
    date = data['date'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    imageURL = data['imageURL'];
    quantity= data['quantity'];
  }

  Map<String, dynamic> toMap() {
    /*
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['date'] = date;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['imageURL'] = imageURL;
    map['quantity'] = quantity;

    return map; */
    return {
      'date': date,
      //'id':id,
      'latitude': latitude,
      'longitude': longitude,
      'imageURL': imageURL,
      'quantity': quantity
    };
  }

}