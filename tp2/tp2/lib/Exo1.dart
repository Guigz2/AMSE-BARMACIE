import 'package:flutter/material.dart';
import 'dart:typed_data';

void main() {
  runApp(MaterialApp(home: Exo1Page(),
  ));
}


class Exo1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}