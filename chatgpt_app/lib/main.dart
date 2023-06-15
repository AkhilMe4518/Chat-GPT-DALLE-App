import 'package:chatgpt_app/screens/firebase_authScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:chatgpt_app/screens/introScreen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatgptApp",
      debugShowCheckedModeBanner: false,
      home: const FirebaseAuthScreen(),
      // home: StreamBuilder(
      //   stream: Firebase.instance.,
      //   builder: (ctx,snapshot){

      // }),
      theme: ThemeData(
        // colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
    );
  }
}
