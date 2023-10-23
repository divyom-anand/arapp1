import 'package:arapp1/localobjects.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  final String title;

  const MyHomePage({required this.title, Key? key}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)),
    body: Center(child: ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ABC()));
    },
    child: const Text("Local Objects"),)),);
  }

}