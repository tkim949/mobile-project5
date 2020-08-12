//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {

test('Test the element of Map should have appropriate values', () {
    final date = Timestamp.fromDate(DateTime.parse('2020-01-01'));
    final quantity = 3;
    final latitude = 1.0;
    final longitude = 2.0;
    final imageURL = 'http';


    final testFood = Food.fromMap({
        'date' : date,
        'imageURL' : imageURL,
        'quantity' : quantity,
        'latitude' : latitude,
        'longitude' : longitude, 
    });

    expect(testFood.date, date);
    expect(testFood.imageURL, imageURL);
    expect(testFood.quantity, quantity);
    expect(testFood.latitude, latitude);
    expect(testFood.longitude, longitude);

    expect(testFood.imageURL, matches('http'));

});

test('Test the element of Map should be correct type', () {
    final date = Timestamp.fromDate(DateTime.parse('2020-01-01'));
    final quantity = 3;
    final latitude = 1.0;
    final longitude = 2.0;
    final imageURL = 'http';


    final testFood = Food.fromMap({
        'date' : date,
        'imageURL' : imageURL,
        'quantity' : quantity,
        'latitude' : latitude,
        'longitude' : longitude, 
    });

    expect(testFood.imageURL.runtimeType, equals(String));
    expect(testFood.date.runtimeType, equals(Timestamp));
    expect(testFood.quantity.runtimeType, equals(int));
    expect(testFood.latitude.runtimeType, equals(double));
    expect(testFood.longitude.runtimeType, equals(double));

});
} 