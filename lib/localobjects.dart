import 'dart:async';
import 'package:tflite/tflite.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';

class ABC extends StatefulWidget{
  ABC({super.key});

  @override
  State<ABC> createState() => _ABC();
}

class _ABC extends State<ABC>{

  late ARSessionManager arSessionManager;
  late ARObjectManager  arObjectManager;
  ARNode? localobjectNode;
  late var text = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(text),
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container( 
                  color: Colors.black,
                  child: ARView(
                    onARViewCreated: onARViewCreated,
                  )
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO
                      },
                      child: const Text("Add / Remove Local Object")),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO
                      },
                      child: const Text("Add / Remove Web Object")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onARViewCreated(ARSessionManager arSessionManager, ARObjectManager arObjectManager, ARAnchorManager arAnchorManager, ARLocationManager arLocationManager) {
  this.arObjectManager=arObjectManager;
  this.arSessionManager=arSessionManager;

  this.arSessionManager.onInitialize(
    showFeaturePoints: false,
    showPlanes: true,
    showWorldOrigin: true,
    handleTaps: false,
    customPlaneTexturePath: "triangle.png",
  );
  this.arObjectManager.onInitialize();
  
  
    Timer.periodic(const Duration(seconds: 1), (timer){getPos(arSessionManager.snapshot());});
  
  // arSessionManager.getCameraPose().asStream();
  }

 void getPos(var img) async{
  var recognitions = await Tflite.detectObjectOnImage(
  model: "SSDMobileNet",  
  path: img,
  imageMean: 127.5,   // defaults to 127.5
  imageStd: 127.5,    // defaults to 90, Android only
  threshold: 0.1,     // defaults to 0.1
  asynch: true        // defaults to true
);
  text = recognitions as String;
}
}