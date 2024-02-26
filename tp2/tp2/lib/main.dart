import 'package:flutter/material.dart';
import 'Exo1.dart';
import 'Exo2.dart' as Exo2;
import 'Exo2b.dart' as Exo2b;
import 'Exo4.dart' as Exo4;
import 'Exo5.dart' as Exo5;
import 'Exo5b.dart' as Exo5b;
import 'Exo5c.dart' as Exo5c;
import 'Exo6.dart' as Exo6;
import 'Exo6b.dart' as Exo6b;
import 'Exo6c.dart' as Exo6c;
import 'Exo7.dart' as Exo7;
import 'Exo7a.dart' as Exo7a;
import 'package:flutter/widgets.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TP2"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text("Exercice 1"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo1Page(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 2"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo2.MonApp(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 2b"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo2b.MonApp(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 4"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo4.DisplayTileWidget(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 5"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo5.MainApp(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 5b"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo5b.MainApp(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 5C"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo5c.MainApp(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 6"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo6.PositionedTiles(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 6b"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo6b.PositionedTiles(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 6c"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo6c.PositionedTiles(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 7"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo7.PositionedTiles(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Exercice 7a"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exo7a.PositionedTiles(),
                      ),
                    );
                  },
                ),
              ),
              // Ajoute les autres exercices ici
            ],
          ),
        ),
      ),
    );
  }
}

