import 'package:flutter_driver/flutter_driver.dart';
//import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';


void main() {
  group('Wasteagram App', () {

    FlutterDriver driver;

    setUpAll( () async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll( () async {
      if(driver != null) {
        driver.close();
      }
    });

    //var textFormField = find.byType("TextFormField");
    
    test('check the button to get a photo', () async {
      final SerializableFinder imageBtn = find.bySemanticsLabel('Get image Button');
      expect(imageBtn, isNotNull);
    });

    test('check the text form field for input num', () async {
      final SerializableFinder inputNum = find.byValueKey('userNumInpt');
      expect(inputNum, isNotNull);
    });

    
    test('check the button for uploading', () async {
      final SerializableFinder button = find.bySemanticsLabel('Upload button');
      expect(button, isNotNull);
    });

    /*test('check input number', () async{  
      //await driver.tap(imageBtn);
      //await Future.delayed(Duration(seconds: 2));
      //await driver.enterText('3');
      //await driver.waitFor(find.text('3'));
      //await driver.waitUntilNoTransientCallbacks();
      //final SerializableFinder imageBtn = find.bySemanticsLabel('Get image Button');
      //expect(tester.widget<FlatButton>(imageBtn).enabled, isTrue);
      
   }); */

  });
}