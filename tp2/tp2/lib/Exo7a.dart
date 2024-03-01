import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2/Exo4.dart';
import 'Route.dart' as route;

// ==============
// Models
// ==============

math.Random random = new math.Random();


class Tile2 {
  String imageURL;
  Alignment alignment;
  int indice_init;

  Tile2({required this.imageURL, required this.alignment, required this.indice_init});
}


// ==============
// Widgets
// ==============


void main() => runApp(MaterialApp(
  home: const PositionedTiles(),
  routes:{
    'Exo7a': (context) => PositionedTiles(),
  }));

class PositionedTiles extends StatefulWidget {
  const PositionedTiles({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {

  //List<Widget> tiles = List<Widget>.generate(15, (index) => TileWidget(Tile.randomColor()));
  int emptytile = math.Random().nextInt(16);
  double nbcol = 4.0;
  int nbcolbefore = 4;
  bool _isImageVisible = false;
  int compteur = 0;
  bool first = true;
  int choix = 0;
  int selectedDifficulty = 0;
  bool test_victory = false;

  List<Tile2> listeTile = [];
  
  @override
  Widget build(BuildContext context) {
    creaList(nbcolbefore);
    inittile();
    melange();
     
    double screenLenght = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text(
          "Jeu de Taquin",
          style: TextStyle(
            fontSize: 40.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.red[100],
            letterSpacing: 2.0,
            wordSpacing: 4.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height : 20,),
          Text(
            "Nombre de déplacements : $compteur",
            style: TextStyle(
              fontSize: 20.0, 
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
              letterSpacing: 2.0,
              wordSpacing: 4.0,
            ),
          ),
          const SizedBox(height: 20,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              if(test_victory == false)
                Container(
                width: screenLenght*0.5,
                height: screenLenght*0.5,
                child:
                      GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nbcolbefore, 
                      crossAxisSpacing: 4.0, 
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 1, 
                    ),
                    itemCount: nbcol.toInt()*nbcol.toInt(), 
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          onPressedMethod(index,emptytile);
                          ifVictory();
                        },
                        child: Container(
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
                if (_isImageVisible || test_victory) 
                  Container(
                    width: screenLenght*0.5,
                    height: screenLenght*0.5, 
                    child: Image.network(
                      'https://picsum.photos/512', 
                      fit: BoxFit.cover,
                    ),
                  ),
            ],
          ),
          const SizedBox(height:20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isImageVisible = !_isImageVisible;
                PositionedTiles;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red[700],),
              foregroundColor: MaterialStateProperty.all(Colors.red[100]), 
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return Colors.blueAccent; 
                  return null;
                },
              ),
              padding: MaterialStateProperty.all(EdgeInsets.all(16)),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)), 
              elevation: MaterialStateProperty.all(10), 
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0), 
                ),
              ),
            ),
            child: const Text("Afficher l'image d'origine"),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nombre de Colonnes : ${nbcol.toInt()}",
                style: TextStyle(
                  fontSize: 17.0, 
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                  letterSpacing: 2.0,
                  wordSpacing: 2.0,
                ),
              ),
              Container(
                width: screenLenght*0.3,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red[700],
                    inactiveTrackColor: Colors.red[100],
                    trackHeight: 15.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.0),
                    thumbColor: Colors.redAccent,
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    activeTickMarkColor: Colors.red[700],
                    inactiveTickMarkColor: Colors.red[100],
                  ),
                  child :Slider(
                    min:2,
                    max: 10,
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
                          nbcolbefore = nbcol.toInt();
                          compteur=0;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          CupertinoSegmentedControl<int>(
            children: const {
              0: Text('Easy'),
              1: Text('Medium'),
              2: Text('Hardore'),
              3: Text('Good Luck'),
            },
            onValueChanged: (int newValue) {
              setState(() {
                selectedDifficulty = newValue;
                compteur = 0;
              }); 
            },
            groupValue: selectedDifficulty,
            unselectedColor: Colors.red[100],
            selectedColor: Colors.red[700],
            borderColor: Colors.red[700],
            pressedColor: Colors.blueAccent,
        ),
        if(test_victory)
                SizedBox(height:20),
        if(test_victory)
                Container(
                  alignment: Alignment.topCenter,
                  width: screenLenght*0.50,
                  child: Center( 
                    child : Text(
                      "Tu as gagné ! Bravo à toi !",
                      style: TextStyle(
                        fontSize: 30.0, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.red[700],
                        letterSpacing: 2.0,
                        wordSpacing: 4.0,
                      ),
                    ),
                  ),
                ),
        if(test_victory)
                SizedBox(height:20),
        if(test_victory)
                ElevatedButton(
                  onPressed: () {
                    setState(() { 
                      test_victory = false; // Réinitialise l'état de victoire
                      Navigator.push(context, MaterialPageRoute(builder: (context) => route.MyApp()));
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[700],),
                    foregroundColor: MaterialStateProperty.all(Colors.red[100]), 
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) return Colors.blueAccent; 
                        return null;
                      },
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)), 
                    elevation: MaterialStateProperty.all(10), 
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), 
                      ),
                    ),
                  ),
                  child: const Text("Reset"),
                ),
        ],
      ),
    );
  }

  showimage()
  {

  }


  onPressedMethod(int index, int Empty_Tile) {
      (Empty_Tile % nbcolbefore == 0) //Colonne de gauche
          ? ((index - Empty_Tile) == nbcolbefore) 
            ? setState(() {
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                emptytile = index;
                compteur += 1;
              })
            : ((index - Empty_Tile) == -nbcolbefore)
              ? setState(() {
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                emptytile = index;
                compteur += 1;
              })
              : ((index - Empty_Tile) == 1)
                ? setState(() {
                listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                emptytile = index;
                compteur += 1;
              })
                : null
            : ((index-nbcolbefore)%nbcolbefore == 0) //Colonne de droite
              ? ((index - Empty_Tile) == nbcolbefore) 
                ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                    emptytile = index;
                    compteur += 1;
                  })
                : ((index - Empty_Tile) == -nbcolbefore)
                  ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                    emptytile = index;
                    compteur += 1;
                  })
                  : ((index - Empty_Tile) == -1)
                    ? setState(() {
                    listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                    emptytile = index;
                    compteur += 1;
                  })
                    : null
                : ((index - Empty_Tile) == nbcolbefore) 
                  ? setState(() {
                      listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                      listeTile.insert(Empty_Tile, listeTile.removeAt(index-1));
                      emptytile = index;
                      compteur += 1;
                    })
                  : ((index - Empty_Tile) == -nbcolbefore)
                    ? setState(() {
                      listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                      listeTile.insert(Empty_Tile, listeTile.removeAt(index+1));
                      emptytile = index;
                      compteur += 1;
                    })
                    : ((index - Empty_Tile).abs() == 1)
                      ? setState(() {
                        listeTile.insert(index, listeTile.removeAt(Empty_Tile));
                        emptytile = index;
                        compteur += 1;
                    })
                      : null;
  }

  inittile(){
    first == true
     ? setState(() {
        emptytile = math.Random().nextInt(nbcolbefore*nbcolbefore);
        listeTile.removeAt(emptytile);
        listeTile.insert(emptytile, Tile2(imageURL: "https://img.freepik.com/photos-gratuite/surface-abstraite-textures-mur-pierre-beton-blanc_74190-8189.jpg?size=626&ext=jpg&ga=GA1.1.1908636980.1708732800&semt=ais", alignment: Alignment(0,0),indice_init: emptytile));
        
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

  Tile2 tileCrea = Tile2(imageURL:'https://picsum.photos/512',alignment: Alignment(largeur,hauteur),indice_init: indexTuile);

    return tileCrea;
  }

creaList(int gridCount){
  //print(gridCount);
  for(int i=0;i<gridCount*gridCount;i++){
    listeTile.add(croppedImageTile(i, gridCount));
  }
  }

 melange(){
      int nb_melange = 0;
      switch(selectedDifficulty){
        case 0:
          nb_melange = 10;
        break;
        case 1:
          nb_melange = 100;
        break;
        case 2:
          nb_melange = 1000;
        break;
        case 3:
         nb_melange = 10000;
        break;
      }

      if(first == true)
      {
      for(int i = 0; i<nb_melange;i++)
        {
          print(i);
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
                  //print("2");
                    listeTile.insert(emptytile-1, listeTile.removeAt(emptytile));
                    emptytile = emptytile-1;
                    //print("3");
                });
                test = false;
                }
                break;

              case 1:
              print("4");
                if((emptytile-nbcolbefore + 1)%nbcolbefore != 0)
                {
                  //print("5");
                setState(() {
                  //print("6");
                    listeTile.insert(emptytile+1, listeTile.removeAt(emptytile));
                    emptytile = emptytile+1;
                    //print("7");
                });
                test = false;
                }
                break;

              case 2:
              print("8");
                if((emptytile-nbcolbefore) >= 0)
                {
                  setState(() {
                    //print("10");
                    listeTile.insert(emptytile-nbcolbefore, listeTile.removeAt(emptytile));
                    //print("11");
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile-nbcolbefore+1));
                    //print("12");
                    emptytile = emptytile-nbcolbefore;
                });
                test = false;
                }
                break;

              default:
              print("13");
                if((emptytile+nbcolbefore) <= nbcolbefore*nbcolbefore-1)
                {
                  //print("14");
                setState(() {
                  //print("15");
                    listeTile.insert(emptytile+nbcolbefore, listeTile.removeAt(emptytile));
                    //print("16");
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile+nbcolbefore-1));
                    //print("17");
                    emptytile = emptytile+nbcolbefore;
                });
                //print("18");
                test = false;
                };
            }
          }
          }
          first = false;
        }
    }

  ifVictory()
    {
      test_victory = true;
      for(int i = 0; i < nbcolbefore*nbcolbefore;i++)
      {
        if(listeTile[i].indice_init != i)
        {
          test_victory = false;
        }
      }
    }
}