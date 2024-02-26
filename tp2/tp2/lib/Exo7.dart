import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tp2/Exo4.dart';


// ==============
// Models
// ==============

math.Random random = new math.Random();


class Tile2 {
  String imageURL;
  Alignment alignment;

  Tile2({required this.imageURL, required this.alignment});
}


// ==============
// Widgets
// ==============


void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {

  //List<Widget> tiles = List<Widget>.generate(15, (index) => TileWidget(Tile.randomColor()));
  int emptytile = math.Random().nextInt(16);
  double nbcol = 4.0;
  int nbcolbefore = 4;

  bool first = true;

  int choix = 0;

  List<Tile2> listeTile = [];
  
  @override
  Widget build(BuildContext context) {
    creaList(nbcolbefore);
    inittile();
    melange();
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
                      crossAxisCount: nbcolbefore, 
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
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: ClipRect(
                                child: Align(
                                  alignment: listeTile[index].alignment,
                                  widthFactor: 1 / nbcolbefore,
                                  heightFactor: 1 / nbcolbefore,
                                  child: Image.network(listeTile[index].imageURL),
                                ),
                              ),
                            ),
                          ),
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
                                listeTile.clear();
                                first = true;
                                //creaList(nbcol.toInt());
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
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                emptytile = index;
              })
            : ((index - Empty_Tile) == -nbcolbefore)
              ? setState(() {
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                emptytile = index;
              })
              : ((index - Empty_Tile) == 1)
                ? setState(() {
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                emptytile = index;
              })
                : null
            : ((index-nbcolbefore)%nbcolbefore == 0) //Colonne de droite
              ? ((index - Empty_Tile) == nbcolbefore) 
                ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                    emptytile = index;
                  })
                : ((index - Empty_Tile) == -nbcolbefore)
                  ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                    emptytile = index;
                  })
                  : ((index - Empty_Tile) == -1)
                    ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    emptytile = index;
                  })
                    : null
                : ((index - Empty_Tile) == nbcolbefore) 
                  ? setState(() {
                      listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                      listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                      emptytile = index;
                    })
                  : ((index - Empty_Tile) == -nbcolbefore)
                    ? setState(() {
                      listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                      listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                      emptytile = index;
                    })
                    : ((index - Empty_Tile).abs() == 1)
                      ? setState(() {
                        listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                        emptytile = index;
                    })
                      : null;
  }

  inittile(){
    first == true
     ? setState(() {
        emptytile = math.Random().nextInt(nbcolbefore*nbcolbefore);
        listeTile.removeAt(emptytile);
        listeTile.insert(emptytile, Tile2(imageURL: "https://img.freepik.com/photos-gratuite/surface-abstraite-textures-mur-pierre-beton-blanc_74190-8189.jpg?size=626&ext=jpg&ga=GA1.1.1908636980.1708732800&semt=ais", alignment: Alignment(0,0)));
        
    })
    : null;
  }

  Tile2 croppedImageTile(int indexTuile, int gridCount) {

    double largeur = -1;
    double hauteur = -1;

    for(int i=1;i<= indexTuile;i++){
      largeur += 2/(gridCount-1);
      if(largeur > 1){
        largeur = -1;
        hauteur += 2/(gridCount-1);
      }
    }

    /*print("largeur : "+ largeur.toString());
    print("hauteur : "+ hauteur.toString());*/

  Tile2 tileCrea = Tile2(imageURL:'https://picsum.photos/512',alignment: Alignment(largeur,hauteur));

    return tileCrea;
  }

creaList(int gridCount){
  //print(gridCount);
  for(int i=0;i<gridCount*gridCount;i++){
    listeTile.add(croppedImageTile(i, gridCount));
  }
  }

  melange(){
      if(first == true)
      {
      for(int i = 0; i<1000;i++)
        {
          bool test = true;
          while(test){
                  setState(() {
                  choix = random.nextInt(4);
                });
              switch (choix) {
              case 0:
              print("1");
                if((emptytile)%nbcolbefore != 0)
                {
                setState(() {
                  print("2");
                    listeTile.insert(emptytile-1, listeTile.removeAt(emptytile));
                    emptytile = emptytile-1;
                    print("3");
                });
                test = false;
                }
                break;

              case 1:
              print("4");
                if((emptytile-nbcolbefore + 1)%nbcolbefore != 0)
                {
                  print("5");
                setState(() {
                  print("6");
                    listeTile.insert(emptytile+1, listeTile.removeAt(emptytile));
                    emptytile = emptytile+1;
                    print("7");
                });
                test = false;
                }
                break;

              case 2:
              print("8");
                if((emptytile-nbcolbefore) > 0)
                {
                  setState(() {
                    print("10");
                    print(emptytile);
                    print(nbcolbefore);
                    listeTile.insert(emptytile-nbcolbefore, listeTile.removeAt(emptytile));
                    print("11");
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile-nbcolbefore+1));
                    print("12");
                    emptytile = emptytile-nbcolbefore;
                });
                test = false;
                }
                break;

              default:
              print("13");
                if((emptytile+nbcolbefore) <= nbcolbefore*nbcolbefore-1)
                {
                  print("14");
                setState(() {
                  print("15");
                    listeTile.insert(emptytile+nbcolbefore, listeTile.removeAt(emptytile));
                    print("16");
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile+nbcolbefore-1));
                    print("17");
                    emptytile = emptytile+nbcolbefore;
                });
                print("18");
                test = false;
                };
            }
          }
          }
          first = false;
        }
    }
}