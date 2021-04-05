import 'package:gme/main.dart';

import 'package:flutter/material.dart';

import 'data_model.dart';
import 'package:provider/provider.dart';

class Layout extends StatelessWidget {
  final Widget titleWidget;
  final Widget leftWidget;
  final Widget rightWidget;

  const Layout({this.titleWidget, this.leftWidget, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.colorAppBackground[context.read<GmeModel>().screen],
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          flex: 1,
          child: TitleArea(
            child: titleWidget,
          ),
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
              child: PanelArea(
                isLeft: true,
                child: leftWidget,
              ),
            ),
            Flexible(
              flex: 1,
              child: PanelArea(
                isLeft: false,
                child: rightWidget,
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class TitleArea extends StatelessWidget {
  final Widget child;
  TitleArea({this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appTheme.colorAppBar[context.read<GmeModel>().screen],
      margin: EdgeInsets.fromLTRB(10, 29, 10, 5),
      child: Center(
        child: child,
      ),
    );
  }
}

class DisplayArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GmeModel>(
        builder: (context, gmeModel, child) => Container(
          color: context.appTheme.colorDisplayMat[context.read<GmeModel>().screen],
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

class PanelArea extends StatelessWidget {
  final Widget child;
  final bool isLeft;
  PanelArea({this.isLeft, this.child}) : super();

  @override
  Widget build(BuildContext context) {
    double lDist = isLeft ? 10 : 0;
    double rDist = 10 - lDist;
    return Container(
      color: context.appTheme.colorMat[context.read<GmeModel>().screen],
      margin: EdgeInsets.fromLTRB(lDist, 5, rDist, 10),
      child: child,
    );
  }
}

class GmeFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GmeFlatButton({this.text, this.onPressed}) : super();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: FlatButton(
          color: context.appTheme.colorMatButton[context.read<GmeModel>().screen],
          textColor: context.appTheme.colorMatButtonText[context.read<GmeModel>().screen],
          onPressed: () => this.onPressed(),
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
