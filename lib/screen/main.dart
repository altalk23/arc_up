import 'package:arc_up/card_list.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/screen/card.dart';
import 'package:arc_up/widget/custom_button.dart';
import 'package:arc_up/widget/custom_label.dart';
import 'package:arc_up/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
    MainScreen({Key key}) : super(key: key);
    
    @override
    _MainScreen createState() {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return _MainScreen();
    }
}

class _MainScreen extends State<MainScreen> {
    
    @override
    Widget build(BuildContext context) {
        return CustomScaffold(
            title: "placeholder",
            child: Container(
                child: ListView(
                    children: <Widget>[
                        ListTile(
                            title: CustomLabel(
                                CardList.type[0],
                                fontSize: Constant.largeFont,
                            ),
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                            return CardScreen(type: 0);
                                        },
                                    ),
                                );
                            },
                        ),
                        ListTile(
                            title: CustomLabel(
                                CardList.type[1],
                                fontSize: Constant.largeFont,
                            ),
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                            return CardScreen(type: 1);
                                        },
                                    ),
                                );
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}
