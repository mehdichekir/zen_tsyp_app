
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/clothing_screnn.dart';
import 'package:zen_tsyp_app/screens/clothing_screens/man_cothing_screen.dart';

class ThreeDRenderdingScreen extends StatefulWidget {
  static const routeName='3d_screen';

   ThreeDRenderdingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ThreeDRenderdingScreen> createState() => _ThreeDRenderdingScreenState();
}

class _ThreeDRenderdingScreenState extends State<ThreeDRenderdingScreen> {
  late String asset;
  Flutter3DController objectController = Flutter3DController();

  bool isLoading = true;

@override
Widget build(BuildContext context) {
  var asset = 'assets/wolf.glb';
  return Scaffold(
    appBar: AppBar(title: const Text('3D Model Viewer')),
    body: Stack(
      children: [
        Column(
          children: [
            if (asset.contains('.glb') || asset.contains('.gltf'))
              SizedBox(
                height: 300,
                child: Flutter3DViewer(
                  onProgress: (progressValue) {
                    if (progressValue == 1.0) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    return SizedBox.shrink();
                  },
                  onLoad: (modelAddress) {
                    print('Model address = $modelAddress');
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onError: (error) {
                    print('Error = $error');
                    setState(() {
                      isLoading = false;
                    });
                  },
                  src: asset,
                  activeGestureInterceptor: true,
                  progressBarColor: Colors.orange,
                  enableTouch: true,
                  controller: objectController,
                ),
              ),
          ],
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          ),
      ],
    ),
  );
}

}



 // TextButton(onPressed: (){
              //   objectController.playAnimation();
              // }, 
              // child: Text('Play')),
              // TextButton(onPressed: (){
              //   objectController.pauseAnimation();
              // },
              //  child: Text('pause'))
              