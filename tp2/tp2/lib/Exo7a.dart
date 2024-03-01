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

//Classe qui permet de créer une Tuile
class Tile2 {
  String imageURL;                //String : URL de l'image donc la Tuile est issue (image mère)
  Alignment alignment;            //Aligment : Alignement de la Tuile dans l'image mère
  int indice_init;                //Int : Indice de la Tuile utiliser pour la condition de victoire

  Tile2({required this.imageURL, required this.alignment, required this.indice_init});    //Constructeur de la classe
}


// ==============
// Widgets
// ==============

//Initilisation de l'activité
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
  int emptytile = math.Random().nextInt(16);                //Int : Indice de la tuile vide donné aléatoirement
  double nbcol = 4.0;                                       //Double : Nombre de colonnes relier au Slider
  int nbcolbefore = 4;                                      //Int : Nombre de colonne actuellement dans le jeu
  bool _isImageVisible = false;                             //bool : Condition d'affiche de l'image d'aide
  int compteur = 0;                                         //Int : compteur de coup
  bool first = true;                                        //Bool : Condition pour l'initialisation de l'espace du jeu
  int choix = 0;                                            //Int : Choix de la direction pour l'initialisation de l'espace de jeu
  int selectedDifficulty = 0;                               //Int : Choix de la difficulté du jeu
  bool test_victory = false;                                //Bool : Condition d'affiche en cas de victoire

  List<Tile2> listeTile = [];                               //Liste<Tile2> : Liste contenant les Tuiles
  
  @override
  Widget build(BuildContext context) {
    creaList(nbcolbefore);                                  //Ajout des Tuiles vides 
    inittile();                                             //Remplissage des Tuile avec les morceaux d'image
    melange();                                              //Melange des tuiles
     
    double screenLenght = MediaQuery.of(context).size.height;   //Double : Hauteur de l'écran 

    return Scaffold(
      backgroundColor: Colors.red[200],                      //Définition de la couleur de l'arrière plan général
      appBar: AppBar(
        backgroundColor: Colors.red[700],                    //Définition de la couleur de l'arrière plan du header
        title: Text(
          "Jeu de Taquin",                                     //Nom du jeu
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
          const SizedBox(height : 20,),                           //Compteur de déplacement
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
              if(test_victory == false)                             //Si le joueur n'a pas gagné on affiche le quadrillage des Tuiles
                Container(
                width: screenLenght*0.5,
                height: screenLenght*0.5,
                child:
                      GridView.builder(                                           //On utilise un Grid view pour le quadrillage
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nbcolbefore, 
                      crossAxisSpacing: 4.0, 
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 1, 
                    ),
                    itemCount: nbcol.toInt()*nbcol.toInt(), 
                    itemBuilder: (context, index) {
                      return GestureDetector(                                     //GestureDetector : Gestion des clics sur les tuiles
                        onTap: (){
                          onPressedMethod(index,emptytile);                       //Appel à la méthode pour gérér les déplacement lors d'un clic sur une tuile
                          ifVictory();                                            //On test si le joueur à gagné
                        },
                        child: Container(                                         //Container contenant les tuiles
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
                                child: Align(                                               //Définition du contenant des tuiles
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
                if (_isImageVisible || test_victory)                                        //Affiche de l'image d'aide si le bouton d'aide est cliqué ou si le joueur à gagner
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
          ElevatedButton(                                                           //Bouton d'aide
            onPressed: () {
              setState(() {
                _isImageVisible = !_isImageVisible;                                 //On changer la valeur du booleen
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
          Row(                                                                  //Slider pour choisir le nombre de colonnes                              
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
          CupertinoSegmentedControl<int>(                                     //Choix de la difficulté
            children: const {
              0: Text('Easy'),
              1: Text('Medium'),
              2: Text('Hardore'),
              3: Text('Good Luck'),
            },
            onValueChanged: (int newValue) {
              setState(() {
                selectedDifficulty = newValue;                                //Si la valeur change on change la valeur de la difficulté
                compteur = 0;                                                 //Remise à 0 du compteur
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
        if(test_victory)                                              //Si victoire affichage du text informatif
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
                ElevatedButton(                                   //Boutton de reset
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


  onPressedMethod(int index, int Empty_Tile) {                                      //Method appelé lors d'un appui sur une Tuile         
      (Empty_Tile % nbcolbefore == 0) //Colonne de gauche                           //Test pour savoir si la tuile vide est sur la colonne gauche (impossuble d'aller encore plus à gauche)
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
            : ((index-nbcolbefore)%nbcolbefore == 0) //Colonne de droite                              //Test pour savoir si la tuile vide est sur la colonne de droite (pas possible d'aller encore plus à droite)
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
              : ((index - Empty_Tile) == nbcolbefore)                                       //Si on est ni sur la colonne de gauche ou de droite (on peut aller à gauche et à droite)
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

  inittile(){                                                           //Méthode pour initialiser les tuiles
    first == true                                                       //Si le premier coup n'a pas été joué :
     ? setState(() {
        emptytile = math.Random().nextInt(nbcolbefore*nbcolbefore);     //Recalcule de la tuile aléatoire en fonction du nombre de colonnes     
        listeTile.removeAt(emptytile);
        listeTile.insert(emptytile, Tile2(imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Fond_blanc.svg/1200px-Fond_blanc.svg.png", alignment: Alignment(0,0),indice_init: emptytile));  //Insertion de la tuile blanche
        
    })
    : null;
  }

  Tile2 croppedImageTile(int indexTuile, int gridCount) {           //Renvoie d'une tuile avec un alignement unique calculé a partir du nombre total de tuile et de a postiion initiale

    double largeur = -1;
    double hauteur = -1;

    for(int i=1;i<= indexTuile;i++){
      largeur += 2/(gridCount-1);
      if(largeur > 1){
        largeur = -1;
        hauteur += 2/(gridCount-1);
      }
    }

  Tile2 tileCrea = Tile2(imageURL:'https://picsum.photos/512',alignment: Alignment(largeur,hauteur),indice_init: indexTuile);

    return tileCrea;
  }

creaList(int gridCount){                                      //Remplissage de la liste à l'aide de la méthode ci-dessus
  for(int i=0;i<gridCount*gridCount;i++){
    listeTile.add(croppedImageTile(i, gridCount));
  }
  }

 melange(){                                                 //mélange des tuile avant que le joueur joue son premier coup, simulation d'un nombre de coup possible
      int nb_melange = 0;
      switch(selectedDifficulty){                           //Choix du nombre de coup pour effectuer le mélange en fonction de la difficulté choisi
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
      for(int i = 0; i<nb_melange;i++)                                          //on effectue x mélange
        {
          bool test = true;                                                   //Booléen pour savoir si le coup à été effectuer
          while(test){                                                        //On essaie de faire un coup aléatoire jusqu'a ce qu'on peut faire le coup (par exemple si la case vide est à droite et que le tirage aléatoire demande de déplacer vers la droite, alors on retirera un autre mouvement jusqu'à que ce soit un coup possible)
                  setState(() {
                  choix = random.nextInt(4);
                });
              switch (choix) {
              case 0:
                if((emptytile)%nbcolbefore != 0)
                {
                setState(() {
                    listeTile.insert(emptytile-1, listeTile.removeAt(emptytile));
                    emptytile = emptytile-1;
                });
                test = false;
                }
                break;

              case 1:
                if((emptytile-nbcolbefore + 1)%nbcolbefore != 0)
                {
                setState(() {
                    listeTile.insert(emptytile+1, listeTile.removeAt(emptytile));
                    emptytile = emptytile+1;
                });
                test = false;
                }
                break;

              case 2:
                if((emptytile-nbcolbefore) >= 0)
                {
                  setState(() {
                    listeTile.insert(emptytile-nbcolbefore, listeTile.removeAt(emptytile));
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile-nbcolbefore+1));
                    emptytile = emptytile-nbcolbefore;
                });
                test = false;
                }
                break;

              default:
                if((emptytile+nbcolbefore) <= nbcolbefore*nbcolbefore-1)
                {
                setState(() {
                    listeTile.insert(emptytile+nbcolbefore, listeTile.removeAt(emptytile));
                    listeTile.insert(emptytile, listeTile.removeAt(emptytile+nbcolbefore-1));
                    emptytile = emptytile+nbcolbefore;
                });
                test = false;
                };
            }
          }
          }
          first = false;                                                                    //Après le mélange on met la variable à faux pour que le joueur puisse jouer son premier coup
        }
    }

  ifVictory()                                                                               //Test pour savoir si le joueur à gagner, on va tester pour savoir si les tuiles sont dans le bonne ordre
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