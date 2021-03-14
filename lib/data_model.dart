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

  GmeModel(BuildContext context) {
    display = "";
    rng = new Random();
  }

  void modify(String field, bool up) {
    data[field] += up ? 1 : -1;
    notifyListeners();
  }

  String getFateMeaning() {
    return TableConstants.getFateAction() + " " + TableConstants.getFateSubject();
  }

  String getFateFocus() {
    String focusStr = "";
    while (focusStr == "") {
      int roll = rng.nextInt(100);
      for (FateFocus focus in TableConstants.fateFocuses) {
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
    String fateDecision = TableConstants.getFateRollString(data["chaos"], likelihood, roll);
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
    List<String> unePieces = [];
    unePieces.add(TableConstants.uneModifiers[rng.nextInt(TableConstants.uneModifiers.length)]);
    unePieces.add(" ");
    unePieces.add(TableConstants.uneNouns[rng.nextInt(TableConstants.uneNouns.length)]);
    String gender = rng.nextInt(2) == 0 ? "m" : "f";
    unePieces.add(" ($gender)\nLevel: ");
    unePieces.add("${TableConstants.getUnePowerLevelString(data["chaos"])}");
    unePieces.add("\nMotivation: ");
    unePieces.add(TableConstants.uneMotivationVerbs[rng.nextInt(TableConstants.uneMotivationVerbs.length)]);
    unePieces.add(" ");
    unePieces.add(TableConstants.uneMotivationNouns[rng.nextInt(TableConstants.uneMotivationNouns.length)]);
    display = unePieces.join();
    notifyListeners();
  }
}
