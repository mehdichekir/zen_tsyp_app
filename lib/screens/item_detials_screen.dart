import 'package:flutter/material.dart';
import 'package:zen_tsyp_app/screens/men_clothing_screen/man_cothing_screen.dart';

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
                    passedData['asset']!, // Replace with your shoe image asset path
                    height: 200,
                  ),
                  // Positioned(
                  //   bottom: 10,
                  //   left: 0,
                  //   right: 0,
                  //   child: Center(
                  //     child: Icon(Icons.circle, size: 16, color: Colors.black),
                  //   ),
                  // ),
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
            // Row(
            //   children: [
            //     Text(
            //       'By',
            //       style: TextStyle(color: Colors.grey, fontSize: 14),
            //     ),
            //     SizedBox(width: 4),
            //     Text(
            //       'Nike Official',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     SizedBox(width: 4),
            //     Icon(Icons.verified, color: Colors.blue, size: 16),
            //   ],
            // ),
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
            // Text(
            //   'SIZE:',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 8),
            // Row(
            //   children: List.generate(5, (index) {
            //     return Padding(
            //       padding: const EdgeInsets.only(right: 8.0),
            //       child: Chip(
            //         label: Text(
            //           '${40 + index}',
            //           style: TextStyle(
            //             color: index == 2 ? Colors.white : Colors.black,
            //           ),
            //         ),
            //         backgroundColor:
            //             index == 2 ? Colors.orange : Colors.grey[200],
            //       ),
            //     );
            //   }),
            // ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  passedData['price']!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.orange,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
