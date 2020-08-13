import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/services.dart'; //for the orientation
import 'package:sentry/sentry.dart' as s;
import 'app.dart';

/* To use Sentry */

const DSN = 'https://6008b38d3e424a279904a258daa9d02e@o432809.ingest.sentry.io/5386834';
final s.SentryClient sentry = s.SentryClient(dsn: DSN);


/* flutter.dev/docs/cookbook/maintenance/error-reporting */
/*  This is to use the analytics.  */

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  //print('Got error: $error');
  /*
  if(isInDebugMode) {
    print(stackTrace);
    return;
  }*/
  final s.SentryResponse response = await sentry.captureException(
    exception: error, stackTrace: stackTrace,);
  if(response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else{
    print('Failed to report to Sentry.io: ${response.error}');
  }
} 
void main() async {
//Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown

  ]);
  
  FlutterError.onError = (FlutterErrorDetails details) async {
    //if(isInDebugMode) {
     // FlutterError.dumpErrorToConsole(details);
   // } else {
       Zone.current.handleUncaughtError(details.exception, details.stack);
   // } 
  };

  runZonedGuarded<Future<void>>( () async{
     runApp(App());
  }, (Object error, StackTrace stackTrace) async {
     _reportError(error, stackTrace);
  });
  /*
  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZoned( () {
    runApp(App(sentry: sentry) );
  }, onError: (error, stackTrace) {
    App.reportError(error, stackTrace);
  });*/
  
}
