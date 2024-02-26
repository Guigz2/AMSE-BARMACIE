import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tp2/Exo4.dart';


// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  late Color color;

  Tile(this.color);

  Tile.randomColor() {
    this.color = Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  setColor(color){
    this.color = color;
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(7.0),
        ));
  }
}

void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {

  List<Widget> tiles = List<Widget>.generate(16, (index) => TileWidget(Tile.randomColor()));

  int emptytile = math.Random().nextInt(16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moving Tiles"),
        centerTitle: true,
      ),
      body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  crossAxisSpacing: 4.0, 
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 4, 
                ),
                itemCount: 4*4, 
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      onPressedMethod(index,emptytile);
                    },
                    child: Container(
                        width: 5.0,  // Remplacez par la largeur souhaitée
                        height: 5.0,
                        decoration: BoxDecoration(
                          border:
                            (index%4 == 0) //Colonne de gauche
                              ? ((index - emptytile).abs() == 4)
                                ? Border.all(color: Colors.black, width: 10)
                                : ((index - emptytile) == -1)
                                  ? Border.all(color: Colors.black, width: 10)
                                  : Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2.0)
                              : (index == 3) ||index == 7 || index == 11 || index == 15 //Colonne de droite
                                ? ((index - emptytile).abs() == 4)
                                  ? Border.all(color: Colors.black, width: 10)
                                  : ((index - emptytile) == 1)
                                    ? Border.all(color: Colors.black, width: 10)
                                    : Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2.0)
                                : ((index - emptytile).abs() == 4)
                                  ? Border.all(color: Colors.black, width: 10)
                                  : ((index - emptytile).abs() == 1)
                                    ? Border.all(color: Colors.black, width: 10)
                                    : Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2.0)
                        ),
                        child: tiles[index]
                      )

                  );
                },
              ),
    );
  }

  onPressedMethod(int index, int Empty_Tile) {
      (Empty_Tile%4 == 0) //Colonne de gauche
          ? ((index - Empty_Tile) == 4) 
            ? setState(() {
                tiles.insert(index, tiles.removeAt(Empty_Tile));
                tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                emptytile = index;
              })
            : ((index - Empty_Tile) == -4)
              ? setState(() {
                tiles.insert(index, tiles.removeAt(Empty_Tile));
                tiles.insert(Empty_Tile, tiles.removeAt(index+1));
                emptytile = index;
              })
              : ((index - Empty_Tile) == 1)
                ? setState(() {
                tiles.insert(index, tiles.removeAt(Empty_Tile));
                emptytile = index;
              })
                : null
            : (Empty_Tile == 3) || Empty_Tile == 7 || Empty_Tile == 11 || Empty_Tile == 15 //Colonne de droite
              ? ((index - Empty_Tile) == 4) 
                ? setState(() {
                    tiles.insert(index, tiles.removeAt(Empty_Tile));
                    tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                    emptytile = index;
                  })
                : ((index - Empty_Tile) == -4)
                  ? setState(() {
                    tiles.insert(index, tiles.removeAt(Empty_Tile));
                    tiles.insert(Empty_Tile, tiles.removeAt(index+1));
                    emptytile = index;
                  })
                  : ((index - Empty_Tile) == -1)
                    ? setState(() {
                    tiles.insert(index, tiles.removeAt(Empty_Tile));
                    emptytile = index;
                  })
                    : null
                : ((index - Empty_Tile) == 4) 
                  ? setState(() {
                      tiles.insert(index, tiles.removeAt(Empty_Tile));
                      tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                      emptytile = index;
                    })
                  : ((index - Empty_Tile) == -4)
                    ? setState(() {
                      tiles.insert(index, tiles.removeAt(Empty_Tile));
                      tiles.insert(Empty_Tile, tiles.removeAt(index+1));
                      emptytile = index;
                    })
                    : ((index - Empty_Tile).abs() == 1)
                      ? setState(() {
                      tiles.insert(index, tiles.removeAt(Empty_Tile));
                      emptytile = index;
                    })
                      : null;
  }
}