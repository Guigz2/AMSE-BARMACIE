import 'package:flutter/material.dart';
import 'dart:typed_data';


class Exo1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Voici une image'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded( 
                child: Image.asset('asterix_affiche.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}