import 'package:gme/main.dart';

import 'common.dart';
import 'data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      titleWidget: Text("Random Generators",
          style: TextStyle(
            fontSize: 30,
            color: context.appTheme.colorAppBarText[context.read<GmeModel>().screen],
          )
      ),
      leftWidget: LeftArea(),
      rightWidget: RightArea(),
    );
  }
}

class LeftArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GmeFlatButton(
            text: "New Dungeon",
            onPressed: () { context.read<GmeModel>().newDungeon(); },
          ),
          GmeFlatButton(
            text: "Dungeon Room",
            onPressed: () { context.read<GmeModel>().newDungeonRoom(); },
          ),
          GmeFlatButton(
            text: "New Region",
            onPressed: () { context.read<GmeModel>().newRegion(); },
          ),
          GmeFlatButton(
            text: "New Town",
            onPressed: () { context.read<GmeModel>().newTown(); },
          ),
          GmeFlatButton(
            text: "Plot Twist",
            onPressed: () { context.read<GmeModel>().newPlotTwist(); },
          ),
          GmeFlatButton(
            text: "Backlash",
            onPressed: () { context.read<GmeModel>().newBacklash(); },
          ),
          GmeFlatButton(
            text: "God Name",
            onPressed: () { context.read<GmeModel>().newGod(); },
          ),
          GmeFlatButton(
            text: "Ship Name",
            onPressed: () { context.read<GmeModel>().newShip(); },
          ),
          GmeFlatButton(
            text: "Furnishings",
            onPressed: () { context.read<GmeModel>().newFurnishings(); },
          ),
          GmeFlatButton(
            text: "Books/Papers",
            onPressed: () { context.read<GmeModel>().newPaperOrBook(); },
          ),
          GmeFlatButton(
            text: "Discipline",
            onPressed: () { context.read<GmeModel>().newDiscipline(); },
          ),
        ]);
  }
}

class RightArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GmeFlatButton(
          text: "Ironsworn Oracle",
          onPressed: () { context.read<GmeModel>().newIronOracle(); },
        ),
        GmeFlatButton(
          text: "Ironsworn Place",
          onPressed: () { context.read<GmeModel>().newIronLocation(); },
        ),
        GmeFlatButton(
          text: "Pay the Price",
          onPressed: () { context.read<GmeModel>().newIronPayThePrice(); },
        ),
        GmeFlatButton(
          text: "Odd Corpse",
          onPressed: () { context.read<GmeModel>().newOddCorpse(); },
        ),
        GmeFlatButton(
          text: "Tattoo",
          onPressed: () { context.read<GmeModel>().newTattoo(); },
        ),
        GmeFlatButton(
          text: "Haunting",
          onPressed: () { context.read<GmeModel>().newHaunting(); },
        ),
        Flexible(
          flex: 4,
          child: Container(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Image.asset("lib/mythic_m_alpha.png"),
                )
            ),
          ),
        ),
        GmeFlatButton(
          text: "Mythic",
          onPressed: () {
            context.read<GmeModel>().screenToggle();
            Navigator.pop(context);
            context.read<GmeModel>().postToggle();
          },
        ),
      ]);
  }
}

