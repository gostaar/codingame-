import 'dart:io';

String readLineSync() {
  String? s = stdin.readLineSync();
  return s == null ? '' : s;
}

void main() {
  int n = int.parse(readLineSync());
  List<Map<String, String>> people = [];

  for (int i = 0; i < n; i++) {
    List<String> inputs = readLineSync().split(' ');
    Map<String, String> person = {
      'name': inputs[0],
      'parent': inputs[1],
      'birth': inputs[2],
      'death': inputs[3],
      'religion': inputs[4],
      'gender': inputs[5],
    };
    people.add(person);
  }

  Map<String, List<Map<String, String>>> parents = {};

  for (var person in people) {
    String parentName = person['parent']!;

    if (!parents.containsKey(parentName)) {parents[parentName] = [];}
    parents[parentName]!.add(person);
  }

  List<Map<String, String>> sortChildren(List<Map<String, String>> children) {
    children.sort((a, b) {
      if (a['gender'] != b['gender']) {return a['gender'] == 'M' ? -1 : 1;}

      int birthA = int.parse(a['birth']!.substring(0, 4));
      int birthB = int.parse(b['birth']!.substring(0, 4));
      return birthA.compareTo(birthB);
    });
    
    return children;
  }

  void printChildren(String parentName) {
    if (parents.containsKey(parentName)) {
      List<Map<String, String>> children = sortChildren(parents[parentName]!);

      for (var child in children) {
        if (child['death'] == '-' ) {
          if (child['religion'] != 'Catholic'){print(child['name']);}
          printChildren(child['name']!);
        } else { 
          printChildren(child['name']!);
        }
      }
    }
  }
  printChildren('-');
}
