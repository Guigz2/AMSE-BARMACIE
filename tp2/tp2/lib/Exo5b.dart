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
}



class MainApp extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    int gridCount = 4; 

    List<Tile> listeTile = creaList(gridCount);
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Plateau de Tuiles'),
        centerTitle: true,
      ),
      body: //Padding(
        //padding: const EdgeInsets.all(100.0), 
        //child: 
        //Center( 
          //child: 
          GridView.builder(
            // Taille image totale :  512x512
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount, 
              crossAxisSpacing: 4.0, 
              mainAxisSpacing: 4.0, 
            ),
            itemCount: gridCount * gridCount, 
            itemBuilder: (context, index) {
              return /*Stack(
                alignment: Alignment.center,
                children: [*/
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5), 
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRect(
                        child: Align(
                          alignment: listeTile[index].alignment,
                          widthFactor: 1 / gridCount,
                          heightFactor: 1 / gridCount,
                          child: Image.network(listeTile[index].imageURL),
                        ),
                      ),
                    ),
                  );
                  /*Text(
                    'Tuile ${index + 1}',
                    style: TextStyle(color: Colors.black),
                  ),*/
                /*],
              );*/
            },
          ),
          //),
      //),
    );
  }


Tile croppedImageTile(int indexTuile, int gridCount) {

    double largeur = -1;
    double hauteur = -1;

    for(int i=1;i<= indexTuile;i++){
      largeur += 2/(gridCount-1);
      if(largeur >= 1){
        largeur = -1;
        hauteur += 2/(gridCount-1);
      }
    }

    print("largeur : "+ largeur.toString());
    print("hauteur : "+ hauteur.toString());
    Tile tileCrea = new Tile(imageURL:'https://picsum.photos/512',alignment: Alignment(largeur,hauteur));

    return tileCrea;
  }

creaList(int gridCount){
  List<Tile> aaa = [];  

  for(int i=0;i<gridCount*gridCount;i++){
    aaa.add(croppedImageTile(i, gridCount));
  }
  return aaa;
}

}
