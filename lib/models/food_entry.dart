import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  
  Timestamp date;
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
    
    return {
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'imageURL': imageURL,
      'quantity': quantity
    };
  }

}