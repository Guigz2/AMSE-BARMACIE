import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  var favorites = List<dynamic>.empty(growable: true);

  void toggleFavorite(var currents){
    if (favorites.contains(currents)){
      favorites.remove(currents);
    } else {
      favorites.add(currents);
    }
    notifyListeners();
  }

  // late List<Film> films;
  var films  = List<Media>.empty();

  Future<void> readJson_films() async {
    try {
      final String response = await rootBundle.loadString('films.json');
      final jsonData = json.decode(response);
      // Récupérer la liste de films à partir du Map
      List<dynamic> filmsData = jsonData['films'];
      // Créer une liste d'objets Film à partir de la liste de données
      films = filmsData.map((filmData) => Media.fromJson(filmData)).toList();
      // Utiliser setState pour mettre à jour l'état du widget
    }
    catch (e) {
      print("Erreur lors de la lecture du fichier JSON : $e");
    }
    notifyListeners();
  }

  // late List<Series> series;
  var series  = List<Media>.empty();

  Future<void> readJson_series() async {
    try {
      final String response = await rootBundle.loadString('films.json');
      final jsonData = json.decode(response);
      // Récupérer la liste de films à partir du Map
      List<dynamic> seriesData = jsonData['series'];
      // Créer une liste d'objets Film à partir de la liste de données
      series = seriesData.map((seriesData) => Media.fromJson(seriesData)).toList();
      // Utiliser setState pour mettre à jour l'état du widget
    }
    catch (e) {
      print("Erreur lors de la lecture du fichier JSON : $e");
    }
    notifyListeners();
  }

  // late List<BDs> bds;
  var bds  = List<Media>.empty();

  Future<void> readJson_bds() async {
    try {
      final String response = await rootBundle.loadString('films.json');
      final jsonData = json.decode(response);
      // Récupérer la liste de films à partir du Map
      List<dynamic> bdsData = jsonData['bds'];
      // Créer une liste d'objets Film à partir de la liste de données
      bds = bdsData.map((bdsData) => Media.fromJson(bdsData)).toList();
      // Utiliser setState pour mettre à jour l'état du widget
    }
    catch (e) {
      print("Erreur lors de la lecture du fichier JSON : $e");
    }
    notifyListeners();
  }

  IconData favorite_icon(Media media){
    IconData icon;
    if (favorites.contains(media)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    return icon;
  }

}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Media {
  final int id;
  final String titre;
  final String auteur;
  final int annee;
  final String img;
  final String description;
  final String type;

  Media({required this.id, required this.titre, required this.auteur, required this.annee, required this.img, required this.description, required this.type});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] as int? ?? 0, // Utilisation de 'as int?' pour indiquer que la valeur peut être null
      titre: json['titre'] as String? ?? 'null', // Utilisation de 'as String?' pour indiquer que la valeur peut être null
      auteur: json['auteur'] as String? ?? 'null', // Utilisation de 'as String?' pour indiquer que la valeur peut être null
      annee: json['annee'] as int? ?? 0, // Utilisation de 'as int?' pour indiquer que la valeur peut être null
      img: json['img'] as String? ?? 'null',
      description: json['description'] as String? ?? 'null',
      type: json['type'] as String? ?? 'null',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.id == id &&
        other.titre == titre &&
        other.auteur == auteur &&
        other.annee == annee;
  }

  @override
  int get hashCode {
    return id.hashCode ^ titre.hashCode ^ auteur.hashCode ^ annee.hashCode;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  
  var selectedIndex = 0;

  @override

  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Liste_Film();
        break;
      case 1:
        page = Liste_Series();
        break;
      case 2:
        page = Liste_BDs();
        break;
      case 3:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context,contraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: contraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.movie),
                      label: Text('Films'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.live_tv),
                      label: Text('Séries'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.book),
                      label: Text('BDs'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class Liste_Film extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.readJson_films();
    List<Media> films = appState.films;

    if (films.isEmpty) {
      return Center(child: Text("No film yet"),
      );
    }

  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0, // Taille maximale pour chaque élément (ajustez selon vos besoins)
        crossAxisSpacing: 8.0, // Espacement horizontal entre les colonnes
        mainAxisSpacing: 8.0, // Espacement vertical entre les lignes
      ),
      itemCount: films.length,
      itemBuilder: (context, index) {
        var film = films[index];

        return 
        ElevatedButton(
          onPressed: () {
            // Naviguer vers la page de destination en passant des données
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Information(data: film),
              ),
            );
          }, 
          child: 
          Card(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(film.titre),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.asset("${film.img}", fit: BoxFit.cover),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(film);
                  },
                  icon: Icon(appState.favorite_icon(film)),
                  label: Text('Like'),
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }
}

class Liste_Series extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.readJson_series();
    List<Media> series = appState.series;

    if (series.isEmpty) {
      return Center(child: Text("No series yet"),
      );
    }

  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0, // Taille maximale pour chaque élément (ajustez selon vos besoins)
        crossAxisSpacing: 8.0, // Espacement horizontal entre les colonnes
        mainAxisSpacing: 8.0, // Espacement vertical entre les lignes
      ),
      itemCount: series.length,
      itemBuilder: (context, index) {
        var serie = series[index];

        return Card(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(serie.titre),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.asset("${serie.img}", fit: BoxFit.cover),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(serie);
                  },
                  icon: Icon(appState.favorite_icon(serie)),
                  label: Text('Like'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Liste_BDs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.readJson_bds();
    List<Media> bds = appState.bds;

    if (bds.isEmpty) {
      return Center(child: Text("No series yet"),
      );
    }

  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0, // Taille maximale pour chaque élément (ajustez selon vos besoins)
        crossAxisSpacing: 8.0, // Espacement horizontal entre les colonnes
        mainAxisSpacing: 8.0, // Espacement vertical entre les lignes
      ),
      itemCount: bds.length,
      itemBuilder: (context, index) {
        var bd = bds[index];

        return Card(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(bd.titre),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.asset("${bd.img}", fit: BoxFit.cover),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(bd);
                  },
                  icon: Icon(appState.favorite_icon(bd)),
                  label: Text('Like'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet"),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child : Text('Vous avez '
                '${appState.favorites.length} favories:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Nom: ${pair.titre}'),
            subtitle: Text('Auteur: ${pair.auteur} | Année: ${pair.annee} | ${pair.runtimeType}'),
            trailing: Image.asset("${pair.img}"),
          ),
      ],
    );
  }
}

class Information extends StatelessWidget {
  
  
  final Media data;

  Information({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image à gauche
          Container(
            width: 120.0, // Ajustez la largeur de l'image selon vos besoins
            height: 160.0, // Ajustez la hauteur de l'image selon vos besoins
            child: Image.asset(
              data.img,
              fit: BoxFit.cover,
            ),
          ),
          // Informations à droite
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.titre,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Auteur: ${data.auteur}"),
                  Text("Année: ${data.annee}"),
                  SizedBox(height: 8.0),
                  Text("${data.description}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}