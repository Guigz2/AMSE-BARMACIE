import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatefulWidget{
  @override
  MainApp createState() => MainApp();
}

class MainApp extends State<MonApp> {
  double _angle_x = 0;
  double _angle_z = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar : AppBar(
          title: Text("Voici une image"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Expanded(
                  child : Transform(
                    transform: Matrix4.identity()
                      ..rotateX(_angle_x)
                      ..rotateZ(_angle_z),
                    alignment: Alignment.center,
                    child: Image.asset('asterix_affiche.jpg'),
                  ),
                ),
                Slider(
                  min:0,
                  max: math.pi,
                  value: _angle_x,
                  onChanged: (double value){
                    setState((){
                      _angle_x = value;
                    });
                  },
                ),
                Slider(
                  min: 0,
                  max: math.pi, 
                  value: _angle_z,
                  onChanged: (double value) {
                    setState(() {
                      _angle_z = value;
                    });
                  },
                ),
              ]
            )
        ),
      ),
    );
  }
}
