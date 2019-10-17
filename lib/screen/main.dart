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
                child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(Constant.padding),
                            child: CustomButton(
                                child: CustomLabel(
                                    CardList.type[index],
                                    fontSize: Constant.largeFont,
                                ),
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                                return CardScreen(type: index);
                                            },
                                        ),
                                    );
                                },
                            ),
                        );
                    },
                    itemCount: 3,
                ),
            ),
        );
    }
}
