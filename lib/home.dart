import 'package:gme/generators_page.dart';
import 'package:gme/main.dart';

import 'common.dart';
import 'data_model.dart';
import 'tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      titleWidget: ChaosArea(),
      leftWidget: FateArea(),
      rightWidget: MiscArea(),
    );
  }
}

class ModifyButton extends StatelessWidget {
  final String field;
  final bool up;
  final Color color;

  const ModifyButton({this.field, this.up, this.color}) : super();

  @override
  Widget build(BuildContext context) {
    var align = up ? Alignment.centerLeft : Alignment.centerRight;
    var icon =
        up ? Icons.add_circle_outline : Icons.remove_circle_outline_outlined;
    return Container(
      alignment: align,
      child: Consumer<GmeModel>(builder: (context, gmeModel, _) {
        return IconButton(
          onPressed: () {
            gmeModel.modify(field, up);
          },
          icon: Icon(icon),
          color: color,
        );
      }),
    );
  }
}

class ChaosArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
      builder: (context, gmeModel, child) => Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chaos Rank ",
                  style: TextStyle(
                    fontSize: 30,
                    color: context.appTheme.colorAppBarText[0],
                  )),
              Visibility(
                visible: gmeModel.data["chaos"] > 1,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: ModifyButton(
                    field: "chaos",
                    up: false,
                    color: context.appTheme.colorAppBarText[0]),
              ),
              Text("${gmeModel.data["chaos"]}",
                  style: TextStyle(
                    fontSize: 30,
                    color: context.appTheme.colorMatText[0],
                  )),
              Visibility(
                visible: gmeModel.data["chaos"] < 9,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: ModifyButton(
                    field: "chaos",
                    up: true,
                    color: context.appTheme.colorMatText[0]),
              ),
            ],
          ),
      ),
    );
  }
}

class FieldButton extends StatelessWidget {
  final String field;

  const FieldButton({this.field}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 39,
          child: Center(
            child: Text(
              Tableaux.fieldDisplays[field],
              style: TextStyle(
                color: context.appTheme.colorMatText[0],
                fontSize: 18,
              ),
            ),
          ),
        ),
        Flexible(
            flex: 61,
            child: Center(
              child: Row(
                children: [
                  ModifyButton(
                      field: field,
                      up: false,
                      color: context.appTheme.colorMatText[0]),
                  Consumer<GmeModel>(
                      builder: (context, gmeModel, child) =>
                          Text("${gmeModel.data[field]}",
                              style: TextStyle(
                                // fontSize: 30,
                                color: context.appTheme.colorMatText[0],
                              ))),
                  ModifyButton(
                      field: field,
                      up: true,
                      color: context.appTheme.colorMatText[0]),
                ],
              ),
            )),
      ],
    );
  }
}

class FateArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int likelihood = 0; likelihood <= 10; likelihood += 1)
          GmeFlatButton(
            text: Tableaux.chaosLikelihoods[likelihood],
            onPressed: () {
              context.read<GmeModel>().chaos(likelihood);
            },
          )
      ]);
  }
}

class MiscArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
      builder: (context, gmeModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GmeFlatButton(
            text: "New Scene",
            onPressed: () {
              context.read<GmeModel>().newScene();
            },
          ),
          GmeFlatButton(
            text: "Fate Meaning",
            onPressed: () {
              context.read<GmeModel>().fateHint();
            },
          ),
          GmeFlatButton(
            text: "New Character",
            onPressed: () {
              context.read<GmeModel>().une();
            },
          ),
          for (String field in ["threads", "pcs", "npcs"])
            Flexible(flex: 1, child: FieldButton(field: field)),
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
            text: "Random Lists",
            onPressed: () {
              context.read<GmeModel>().screenToggle();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GeneratorsScreen())
              );
              context.read<GmeModel>().postToggle();
            },
          ),
        ]),
    );
  }
}
