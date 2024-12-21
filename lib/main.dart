import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zen_tsyp_app/screens/3d_rendring_screen.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/clothing_screnn.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/man_cothing_screen.dart';
import 'package:zen_tsyp_app/screens/item_detials_screen.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/woman_clothing_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
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
      home:  ClothingScreen(),
      routes: {
        ItemDetialsScreen.routeName:(context)=>ItemDetialsScreen(),
        ManCothingScreen.routeName:(context)=>ManCothingScreen()
      },
    );
  }
}

