import 'dart:io';

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

  setColor(color){
    tile.color = color;
  }
}

void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {

  List<Widget> tiles = List<Widget>.generate(15, (index) => TileWidget(Tile.randomColor()));
  int emptytile = math.Random().nextInt(16);
  double nbcol = 4.0;
  int nbcolbefore = 4;

  bool first = true;
  
  @override
  Widget build(BuildContext context) {
    inittile();
    return Scaffold(
      appBar: AppBar(
        title: Text("Moving Tiles"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child:
          GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nbcol.toInt(), 
                      crossAxisSpacing: 4.0, 
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 4, 
                    ),
                    itemCount: nbcol.toInt()*nbcol.toInt(), 
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          onPressedMethod(index,emptytile);
                        },
                        child: Container(
                            width: 50.0,  // Remplacez par la largeur souhaitée
                            height: 50.0,
                            decoration: BoxDecoration(
                              border:
                                (index%nbcolbefore == 0) //Colonne de gauche
                                  ? ((index - emptytile).abs() == nbcolbefore)
                                    ? Border.all(color: Colors.black, width: 10)
                                    : ((index - emptytile) == -1)
                                      ? Border.all(color: Colors.black, width: 10)
                                      : Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2.0)
                                  : ((index-nbcolbefore+1)%nbcolbefore == 0)//Colonne de droite
                                    ? ((index - emptytile).abs() == nbcolbefore)
                                      ? Border.all(color: Colors.black, width: 10)
                                      : ((index - emptytile) == 1)
                                        ? Border.all(color: Colors.black, width: 10)
                                        : Border.all(color: const Color.fromARGB(255, 255, 0, 0), width: 2.0)
                                    : ((index - emptytile).abs() == nbcolbefore)
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
                ),
          Row(
            children: [
              Text("Nombre de Colonnes :" + nbcol.toInt().toString()),
              Expanded(child: Slider(
                          min:3,
                          max: 20,
                          value: nbcol,
                          onChanged: (double value){                            
                            setState((){
                              nbcol = value;
                            });
                            if (nbcolbefore != nbcol.toInt())
                            {
                              setState(() {
                                tiles.clear();
                                tiles = List<Widget>.generate(nbcol.toInt()*nbcol.toInt(), (index) => TileWidget(Tile.randomColor()));
                                nbcolbefore = nbcol.toInt();
                              });
                              
                            }
                          },
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onPressedMethod(int index, int Empty_Tile) {
      (Empty_Tile % nbcolbefore == 0) //Colonne de gauche
          ? ((index - Empty_Tile) == nbcolbefore) 
            ? setState(() {
                tiles.insert(index, tiles.removeAt(Empty_Tile));
                tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                emptytile = index;
              })
            : ((index - Empty_Tile) == -nbcolbefore)
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
            : ((index-nbcolbefore)%nbcolbefore == 0) //Colonne de droite
              ? ((index - Empty_Tile) == nbcolbefore) 
                ? setState(() {
                    tiles.insert(index, tiles.removeAt(Empty_Tile));
                    tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                    emptytile = index;
                  })
                : ((index - Empty_Tile) == -nbcolbefore)
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
                : ((index - Empty_Tile) == nbcolbefore) 
                  ? setState(() {
                      tiles.insert(index, tiles.removeAt(Empty_Tile));
                      tiles.insert(Empty_Tile, tiles.removeAt(index-1));
                      emptytile = index;
                    })
                  : ((index - Empty_Tile) == -nbcolbefore)
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

  inittile(){
    first == true
     ? setState(() {
        tiles.insert(emptytile, TileWidget(Tile(Colors.transparent)));
        first = false;
    })
    : null;
  }
}