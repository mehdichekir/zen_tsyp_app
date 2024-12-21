import 'package:flutter/material.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/man_cothing_screen.dart';

class ItemDetialsScreen extends StatelessWidget {
  static const routeName ='/item_detials_screen';
  @override
  Widget build(BuildContext context) {
    var passedData= ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(ManCothingScreen.routeName);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Image.asset(
                    passedData['asset']!, 
                    height: 200,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              passedData['title']!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  '5.0 (124 reviews)',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(height: 16),
            Text(
              'DESCRIPTION:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              passedData['desrciption']!,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
