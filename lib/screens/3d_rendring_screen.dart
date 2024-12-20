
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter/material.dart';
import 'package:zen_tsyp_app/screens/men_clothing_screen/man_cothing_screen.dart';

class ThreeDRenderdingScreen extends StatelessWidget {
  final String asset; 
  Flutter3DController objectController = Flutter3DController();

   ThreeDRenderdingScreen({
    required this.asset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D Model Viewer')),
      body: Container(
        height: 500,
        child: Stack(
          children:[
            Column(
            children: [
              if(asset.contains('.obj'))
              Expanded(
              
                child:Flutter3DViewer.obj(
                  scale: 0,
                  cameraX: 0,
                  cameraY: 0,
                  cameraZ: 10,
                onProgress: (progressValue) {
                  print('progressValue=$progressValue');
                },
                onLoad: (modelAddress) {
                  print('model adress = $modelAddress');
                },
                onError: (error) {
                  print('error=$error');
                },
                src: asset,
              ) ,
              ),
              if(asset.contains('.glb') || asset.contains('.gltf'))
                   SizedBox(
                height: 300,
                child:Flutter3DViewer(
                onProgress: (progressValue) {
                  print('progressValue=$progressValue');
                },
                onLoad: (modelAddress) {
                  print('model adress = $modelAddress');
                },
                onError: (error) {
                  print('error=$error');
                },
                src: asset,
                activeGestureInterceptor: true,
                progressBarColor: Colors.orange,
                enableTouch: true,
                controller: objectController,
              ) ,
              ),
              // TextButton(onPressed: (){
              //   objectController.playAnimation();
              // }, 
              // child: Text('Play')),
              // TextButton(onPressed: (){
              //   objectController.pauseAnimation();
              // },
              //  child: Text('pause'))
              
              
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  showGeneralDialog(context: context,
                  pageBuilder: (context,animation1,animation2){
                    return ManCothingScreen();
                  });
                },
                icon: Icon(Icons.person_2))
            ],
          )
          ] ,
        )
      ),
    );
  }
}