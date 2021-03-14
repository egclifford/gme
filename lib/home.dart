import 'package:gme/main.dart';

import 'data_model.dart';
import 'tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: AppBarLayout(),
      // ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          flex: 1,
          child: ChaosArea(),
        ),
        Flexible(
          flex: 2,
          child: DisplayArea(),
        ),
        Flexible(
          flex: 7,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              flex: 1,
              child: FateArea(),
            ),
            Flexible(
              flex: 1,
              child: MiscArea(),
            ),
          ]),
        ),
      ]),
    );
  }
}

class GmeFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GmeFlatButton({this.text, this.onPressed}) : super();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: FlatButton(
        color: context.appTheme.colorMatButton,
        textColor: context.appTheme.colorMatButtonText,
        onPressed: () => this.onPressed(),
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
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

class AppBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("GM Emulator",
          style: TextStyle(
            fontSize: 30,
            color: context.appTheme.colorAppBarText,
          )),
    );
  }
}

class ChaosArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
      builder: (context, gmeModel, child) => Container(
        child: Container(
          color: context.appTheme.colorAppBar,
          margin: EdgeInsets.fromLTRB(10, 27, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chaos Rank ",
                  style: TextStyle(
                    fontSize: 30,
                    color: context.appTheme.colorAppBarText,
                  )),
              Visibility(
                visible: gmeModel.data["chaos"] > 1,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: ModifyButton(
                    field: "chaos",
                    up: false,
                    color: context.appTheme.colorAppBarText),
              ),
              Text("${gmeModel.data["chaos"]}",
                  style: TextStyle(
                    fontSize: 30,
                    color: context.appTheme.colorMatText,
                  )),
              Visibility(
                visible: gmeModel.data["chaos"] < 9,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: ModifyButton(
                    field: "chaos",
                    up: true,
                    color: context.appTheme.colorMatText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
        builder: (context, gmeModel, child) => Container(
              color: context.appTheme.colorDisplayMat,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Center(
                child: Text(
                  gmeModel.display,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ));
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
              TableConstants.fieldDisplays[field],
              style: TextStyle(
                color: context.appTheme.colorMatText,
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
                      color: context.appTheme.colorMatText),
                  Consumer<GmeModel>(
                      builder: (context, gmeModel, child) =>
                          Text("${gmeModel.data[field]}",
                              style: TextStyle(
                                // fontSize: 30,
                                color: context.appTheme.colorMatText,
                              ))),
                  ModifyButton(
                      field: field,
                      up: true,
                      color: context.appTheme.colorMatText),
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
    return Container(
      color: context.appTheme.colorMat,
      margin: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int likelihood = 0; likelihood <= 10; likelihood += 1)
              Flexible(
                flex: 1,
                child: GmeFlatButton(
                  text: TableConstants.chaosLikelihoods[likelihood],
                  onPressed: () {
                    context.read<GmeModel>().chaos(likelihood);
                  },
                )
              )
          ]),
    );
  }
}

class MiscArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
        builder: (context, gmeModel, child) => Container(
              color: context.appTheme.colorMat,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 1,
                      child: GmeFlatButton(
                        text: "New Scene",
                        onPressed: () {
                          context.read<GmeModel>().newScene();
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GmeFlatButton(
                        text: "Fate Meaning",
                        onPressed: () {
                          context.read<GmeModel>().fateHint();
                        },
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: GmeFlatButton(
                          text: "New Character",
                          onPressed: () {
                            context.read<GmeModel>().une();
                          },
                        )),
                    for (String field in ["threads", "pcs", "npcs"])
                      Flexible(flex: 1, child: FieldButton(field: field)),
                    Flexible(
                      flex: 5,
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Image.asset("lib/mythic_m_alpha.png"),
                          )
                        ),
                      ),
                    ),
                  ]),
            ));
  }
}
