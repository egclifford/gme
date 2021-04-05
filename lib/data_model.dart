import 'dart:math';
import 'tables.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GmeModel with ChangeNotifier {
  Map<String, int> data = {
    "chaos": 5,
    "threads": 1,
    "pcs": 1,
    "npcs": 0,
  };
  String display;
  var rng;
  int screen;

  GmeModel(BuildContext context) {
    screen = 0;
    display = "";
    rng = new Random();
  }

  void screenToggle() {
    display = "";
    screen = 1 - screen;
    notifyListeners();
  }

  void postToggle() {
    notifyListeners();
  }

  void modify(String field, bool up) {
    data[field] += up ? 1 : -1;
    notifyListeners();
  }

  String getFateMeaning() {
    return Tableaux.getFateAction() + " " + Tableaux.getFateSubject();
  }

  String getFateFocus() {
    String focusStr = "";
    while (focusStr == "") {
      int roll = rng.nextInt(100);
      for (FateFocus focus in Tableaux.fateFocuses) {
        if (roll <= focus.threshold) {
          if (focus.isNpc && data["npcs"] > 0) {
            int target = rng.nextInt(data["npcs"]) + 1;
            focusStr = focus.display + "$target";
          } else if (focus.isPc && data["pcs"] > 0) {
            int target = rng.nextInt(data["pcs"]) + 1;
            focusStr = focus.display + "$target";
          } else if (focus.isThread && data["threads"] > 0) {
            int target = rng.nextInt(data["threads"]) + 1;
            focusStr = focus.display + "$target";
          } else if (!focus.isThread && !focus.isNpc && !focus.isPc) {
            focusStr = focus.display;
          }
        }
        if (focusStr != "") break;
      }
    }
    return focusStr;
  }

  String getInterrupt() {
    return "Interrupt!\n" + getFateFocus() + "\n" + getFateMeaning();
  }

  void chaos(int likelihood) {
    int roll = rng.nextInt(100) + 1;
    String fateDecision = Tableaux.getFateRollString(data["chaos"], likelihood, roll);
    String interrupt = "";
    if (roll%11 == 0 && roll/11 <= data["chaos"]) {
      interrupt = "\n" + getInterrupt();
    }
    display = fateDecision + interrupt;
    notifyListeners();
  }

  void newScene() {
    int roll = rng.nextInt(10) + 1;
    display = "Proceed with scene as planned.";
    if (roll <= data["chaos"]) {
      if (roll%2 == 0) {
        display = getInterrupt();
      } else {
        display = "Altered scene!";
      }
    }
    notifyListeners();
  }

  void fateHint() {
    display = getFateMeaning();
    notifyListeners();
  }

  void une() {
    String gender = rng.nextBool() ? "m" : "f";
    List<String> unePieces = [];
    unePieces.add(Tableaux.getName(gender == "m"));
    unePieces.add(" ($gender)\n");
    unePieces.add(Tableaux.uneModifiers[rng.nextInt(Tableaux.uneModifiers.length)]);
    unePieces.add(" ");
    unePieces.add(Tableaux.uneNouns[rng.nextInt(Tableaux.uneNouns.length)]);
    unePieces.add("\nLevel: ");
    unePieces.add("${Tableaux.getUnePowerLevelString(data["chaos"])}");
    unePieces.add("\nMotive: ");
    unePieces.add(Tableaux.uneMotivationVerbs[rng.nextInt(Tableaux.uneMotivationVerbs.length)]);
    unePieces.add(" ");
    unePieces.add(Tableaux.uneMotivationNouns[rng.nextInt(Tableaux.uneMotivationNouns.length)]);
    display = unePieces.join();
    notifyListeners();
  }

  // Second screen calls.
  void newDungeon() {
    display = Tableaux.getDungeon();
    notifyListeners();
  }

  void newDungeonRoom() {
    display = Tableaux.getDungeonRoom();
    notifyListeners();
  }

  void newTown() {
    display = Tableaux.getTown();
    notifyListeners();
  }

  void newRegion() {
    display = Tableaux.getRegion();
    notifyListeners();
  }

  void newFurnishings() {
    display = Tableaux.getFurnishings();
    notifyListeners();
  }

  void newShip() {
    display = Tableaux.getShip();
    notifyListeners();
  }

  void newGod() {
    display = Tableaux.getGodName();
    notifyListeners();
  }

  void newDiscipline() {
    display = Tableaux.getDiscipline();
    notifyListeners();
  }

  void newBacklash() {
    display = Tableaux.getBacklash();
    notifyListeners();
  }

  void newPaperOrBook() {
    display = Tableaux.getPaperOrBook();
    notifyListeners();
  }

  void newPlotTwist() {
    display = Tableaux.getPlotTwist();
    notifyListeners();
  }

  void newIronOracle() {
    display = Tableaux.getIronOracle();
    notifyListeners();
  }

  void newIronPayThePrice() {
    display = Tableaux.getIronPayThePrice(false);
    notifyListeners();
  }

  void newIronLocation() {
    display = Tableaux.getIronLocation();
    notifyListeners();
  }

  void newOddCorpse() {
    display = Tableaux.getOddCorpse();
    notifyListeners();
  }

  void newTattoo() {
    display = Tableaux.getTattoo();
    notifyListeners();
  }

  void newHaunting() {
    display = Tableaux.getHaunting();
    notifyListeners();
  }
}
