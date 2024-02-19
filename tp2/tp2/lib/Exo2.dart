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
  bool _isMirrored = false;
  double _scale = 1;

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
                  child : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(color: Colors.white),
                      child : Transform(
                        transform: Matrix4.identity()
                          ..rotateX(_angle_x)
                          ..rotateZ(_angle_z)
                          ..scale(_isMirrored ? -_scale:_scale, _scale),
                        alignment: Alignment.center,
                        child: Image.asset('asterix_affiche.jpg'),
                     ),
                  ),
                ),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RotationX :"),
                    Expanded( 
                      child : Slider(
                        min:0,
                        max: math.pi,
                        value: _angle_x,
                        onChanged: (double value){
                          setState((){
                            _angle_x = value;
                          });
                        },
                      ),
                    ),
                  ]
                ),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("RotationZ :"),
                    Expanded( 
                      child : Slider(
                        min:0,
                        max: math.pi,
                        value: _angle_z,
                        onChanged: (double value){
                          setState((){
                            _angle_z = value;
                          });
                        },
                      ),
                    ),
                  ]
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isMirrored = !_isMirrored; 
                    });
                  },
                  child: Text(_isMirrored ? 'Normal' : 'Miroir'), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scale: '),
                    Expanded(
                      child: Slider(
                        min: 0, 
                        max: 2.0, 
                        value: _scale,
                        onChanged: (double value) {
                          setState(() {
                            _scale = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ]
            )
        ),
      ),
    );
  }
}