import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zen_tsyp_app/helpers/auth_wrapper.dart';
import 'package:zen_tsyp_app/screens/3d_rendring_screen.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/clothing_screnn.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/man_cothing_screen.dart';
import 'package:zen_tsyp_app/screens/face_body_validation_screen.dart';
import 'package:zen_tsyp_app/screens/item_detials_screen.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/woman_clothing_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

late FirebaseFirestore firestore;
late FirebaseAuth auth;
late FirebaseStorage storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.any((app) => app.name == 'Zen')) {
    FirebaseApp zenApp = Firebase.app('Zen');
    firestore = FirebaseFirestore.instanceFor(app: zenApp);
    auth = FirebaseAuth.instanceFor(app: zenApp);
    storage = FirebaseStorage.instanceFor(app: zenApp);
  } else {
    FirebaseApp zenApp = await Firebase.initializeApp(
      name: 'Zen',
      options: FirebaseOptions(
        apiKey: 'AIzaSyAIafS8lcMaUwgDmFncdmQqPHXp6BRYIwE',
    appId: '1:22686388340:android:faa6b0f5916bf95c170121',
    messagingSenderId: '22686388340',
    projectId: 'zen-challenge',
    storageBucket: 'zen-challenge.firebasestorage.app',
      ),
    );

    firestore = FirebaseFirestore.instanceFor(app: zenApp);
    auth = FirebaseAuth.instanceFor(app: zenApp);
    storage = FirebaseStorage.instanceFor(app: zenApp);
  }

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AuthWrapper(),
      routes: {
        ItemDetialsScreen.routeName:(context)=>ItemDetialsScreen(),
        ManCothingScreen.routeName:(context)=>ManCothingScreen(),
        FaceBodyValidationScreen.routeName:(context)=>FaceBodyValidationScreen(),
        ThreeDRenderdingScreen.routeName:(context)=>ThreeDRenderdingScreen(),
        ClothingScreen.routeName:(context)=>ClothingScreen()
      },
    );
  }
}

