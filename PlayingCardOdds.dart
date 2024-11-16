import 'dart:io';
import 'dart:math';

String readLineSync() {
  String? s = stdin.readLineSync();
  return s == null ? '' : s;
}

Set<String> removedCartes = {};
Set<String> sougthCartes = {};

void ajouterCarte(String carte, String couleur) {
  String nouvelleCarte = '${carte}${couleur}';
  removedCartes.add(nouvelleCarte); 
}

void ajouterCarteCherchee(String carte, String couleur){
  String nouvelleCarte = '${carte}${couleur}';
  sougthCartes.add(nouvelleCarte);
}

void main() {
  List inputs;
  inputs = readLineSync().split(' ');
  int R = int.parse(inputs[0]);
  int S = int.parse(inputs[1]);

  List<String> couleurs = ['C', 'D', 'H', 'S'];
  List<String> cartesJeu = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];

  for(int i = 0; i < R; i++) {
    String removed = readLineSync();
    List<String> cartes = removed.split('');
    RegExp regExp = RegExp(r"[2-9TJQKA]");
    RegExp regExpColor = RegExp(r'[CDHS]');

    bool matchFound = cartes.any((carte) => regExp.hasMatch(carte));
    bool matchFoundColor = cartes.any((carte) => regExpColor.hasMatch(carte));
    List<String> carteCouleur = cartes.where((carte) => regExpColor.hasMatch(carte)).toList();
    List<String> carteTrouvee = cartes.where((carte) => regExp.hasMatch(carte)).toList();

    if (matchFound) { regExp = RegExp('0');}
    if (matchFoundColor) {regExpColor = RegExp('0');}

    if (regExp.pattern != '0' && regExpColor.pattern == '0'){
      for(var couleur in cartes) {
        for(var carte in cartesJeu){
          ajouterCarte(carte,couleur);
        }
      }
    } else if (regExp.pattern == '0' && regExpColor.pattern != '0'){
      for(var carte in cartes) {
        for(var couleur in couleurs){
          ajouterCarte(carte,couleur);
        }
      }
    } else if (regExp.pattern == '0' && regExpColor.pattern == '0'){
      for(var carte in carteTrouvee){
        for(var couleur in carteCouleur){
          ajouterCarte(carte,couleur);
        }
      }      
    }
  }  

  for(int i = 0; i < S; i++) {
    String sougth = readLineSync();
    List<String> cartes = sougth.split('');
    
    RegExp regExp = RegExp(r"[2-9TJQKA]");
    RegExp regExpColor = RegExp(r'[CDHS]');

    bool matchFound = cartes.any((carte) => regExp.hasMatch(carte));
    bool matchFoundColor = cartes.any((carte) => regExpColor.hasMatch(carte));
    
    List<String> carteCouleur = cartes.where((carte) => regExpColor.hasMatch(carte)).toList();
    List<String> carteTrouvee = cartes.where((carte) => regExp.hasMatch(carte)).toList();

    if (matchFound) { regExp = RegExp('0');}
    if (matchFoundColor) {regExpColor = RegExp('0');}

    if (regExp.pattern != '0' && regExpColor.pattern == '0'){
      for(var couleur in cartes) {
        for(var carte in cartesJeu){
          if(!removedCartes.contains('${carte}${couleur}')){
            ajouterCarteCherchee(carte, couleur);
          }
        }
      }
    } else if (regExp.pattern == '0' && regExpColor.pattern != '0'){
      for(var carte in cartes) {
        for(var couleur in couleurs){
          if(!removedCartes.contains('${carte}${couleur}')){
            ajouterCarteCherchee(carte, couleur);
          }
        }
      }
    } else if (regExp.pattern == '0' && regExpColor.pattern == '0'){
      for(var carte in carteTrouvee){
        for(var couleur in carteCouleur){
          if(!removedCartes.contains('${carte}${couleur}')){
            ajouterCarteCherchee(carte, couleur);
          }
        }
      }      
    }
  }
  print('${(sougthCartes.length/(52-removedCartes.length)*100).toStringAsFixed(0)}%');
}
