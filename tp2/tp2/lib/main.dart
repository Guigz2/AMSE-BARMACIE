import 'package:flutter/material.dart';
import 'Exo1.dart';
import 'Exo2.dart' as Exo2;
import 'Exo2b.dart' as Exo2b;
import 'Exo4.dart' as Exo4;
import 'Exo5.dart' as Exo5;
import 'Exo5b.dart' as Exo5b;
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
              // Ajoute les autres exercices ici
            ],
          ),
        ),
      ),
    );
  }
}

