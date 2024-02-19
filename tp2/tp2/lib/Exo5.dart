import 'package:flutter/material.dart';
import 'dart:math' as math;


void main() {
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int gridCount = 4; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Plateau de Tuiles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0), 
        child: Center( 
          child: Expanded(
            child: Container( 
              width: 700,
              height: 700,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount, 
                  crossAxisSpacing: 4.0, 
                  mainAxisSpacing: 4.0, 
                ),
                itemCount: gridCount * gridCount, 
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.primaries[math.Random().nextInt(Colors.primaries.length)], 
                          border: Border.all(color: Colors.black, width: 0.5), 
                        ),
                      ),
                      Text(
                        'Tuile ${index + 1}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
