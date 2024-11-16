import 'dart:io';
import 'dart:collection';

String readLineSync() {
  String? s = stdin.readLineSync();
  return s == null ? '' : s;
}

void main() {
  // Lecture de la taille de la grille
  int N = int.parse(readLineSync());
  
  // Lecture de la grille
  List<List<int>> grid = [];
  for (int i = 0; i < N; i++) {
    List<String> inputs = readLineSync().split(' ');
    grid.add(inputs.map(int.parse).toList());
  }

  // Initialisation des points de départ et d'arrivée
  int startX = N ~/ 2;
  int startY = N ~/ 2;
  Map<String, int> finalCoords = {'x': 0, 'y': 0}; // Coordonnées finales à personnaliser

  // Directions possibles (haut, bas, gauche, droite)
  List<List<int>> directions = [
    [-1, 0], // Haut
    [1, 0],  // Bas
    [0, -1], // Gauche
    [0, 1],  // Droite
  ];

  // File pour BFS
  Queue<List<int>> queue = Queue();
  queue.add([startX, startY]);

  // Marquage des cases visitées
  Set<String> visited = {};
  visited.add('$startX,$startY');

  // Recherche BFS
  bool found = false;
  while (queue.isNotEmpty) {
    var current = queue.removeFirst();
    int x = current[0];
    int y = current[1];
    int currentElevation = grid[x][y];

    // Vérifier si on a atteint les coordonnées finales
    if (x == finalCoords['x'] && y == finalCoords['y']) {
      found = true;
      break;
    }

    // Explorer les voisins
    for (var direction in directions) {
      int newX = x + direction[0];
      int newY = y + direction[1];

      // Vérifier si le voisin est valide
      if (newX >= 0 &&
          newX < N &&
          newY >= 0 &&
          newY < N &&
          !visited.contains('$newX,$newY')) {
        int neighborElevation = grid[newX][newY];

        // Vérifier la contrainte sur les élévations
        if ((neighborElevation == currentElevation) ||
            (neighborElevation == currentElevation + 1) ||
            (neighborElevation == currentElevation - 1)) {
          queue.add([newX, newY]);
          visited.add('$newX,$newY');
        }
      }
    }
  }

  // Résultat
  print(found ? "Yes" : "No");
}
