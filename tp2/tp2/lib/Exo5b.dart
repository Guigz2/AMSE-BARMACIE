import 'package:flutter/material.dart';
import 'dart:math' as math;


void main() {
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = new Tile(
    imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));


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
                          image: DecorationImage(
                            image: NetworkImage(tile.imageURL),
                            fit: BoxFit.cover,
                            ),
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


  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
