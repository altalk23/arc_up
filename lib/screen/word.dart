import 'dart:core';

import 'package:arc_up/card_list.dart';
import 'package:arc_up/widget/custom_scaffold.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/widget/custom_label.dart';
import 'package:flutter/material.dart';

class WordScreen extends StatefulWidget {
    WordScreen({Key key}) : super(key: key);
    
    @override
    _WordScreen createState() {
        return _WordScreen();
    }
}

class _WordScreen extends State<WordScreen> {
    
    List<String> keys = CardList.exp.keys.toList();
    
    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery
          .of(context)
          .size;
        double itemHeight = 76;
        double itemWidth = size.width / 2;
        return CustomScaffold(
            title: "Kelime Listesi",
            child: Center(
                child: Container(
                    child: GridView.count(
                        childAspectRatio: (itemWidth / itemHeight),
                        children: List.generate(CardList.exp.length, (index) {
                            return Padding(
                                padding: const EdgeInsets.all(Constant.padding),
                                child: Container(
                                    decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                                HSVColor.fromAHSV(1, 200, 0.80, 0.91).toColor(),
                                                HSVColor.fromAHSV(1, 121, 0.65, 0.96).toColor(),
                                            ],
                                        ),
                                    ),
                                    child: ListTile(
                                        title: CustomLabel(
                                            keys[index],
                                            fontSize: Constant.mediumFont,
                                            
                                        ),
                                        onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                    return SimpleDialog(
                                                        backgroundColor: Color(0x00000000),
                                                        title: CustomLabel(
                                                            keys[index],
                                                            fontSize: Constant.largeFont,
                                                        ),
                                                        children: <Widget>[
                                                            Text(
                                                                CardList.exp[keys[index]],
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: Constant.smallFont,
                                                                ),
                                                            )
                                                        ],
                                                    );
                                                },
                                            );
                                        },
                                    ),
                                ),
                            );
                        },),
                        crossAxisCount: 2,
                    ),
                ),
            ),
        );
    }
    
}
/*
Padding(
                                padding: const EdgeInsets.all(Constant.padding),
                                child: Container(
                                    decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                                HSVColor.fromAHSV(1, 200, 0.80, 0.91).toColor(),
                                                HSVColor.fromAHSV(1, 121, 0.65, 0.96).toColor(),
                                            ],
                                        ),
                                    ),
                                    child: GestureDetector(
                                        onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                    return SimpleDialog(
                                                        backgroundColor: Color(0x00000000),
                                                        title: CustomLabel(
                                                            keys[index],
                                                            fontSize: Constant.largeFont,
                                                        ),
                                                        children: <Widget>[
                                                            Text(
                                                                CardList.exp[keys[index]],
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: Constant.smallFont,
                                                                ),
                                                            )
                                                        ],
                                                    );
                                                },
                                            );
                                        },
                                        child: ListTile(
                                            title: CustomLabel(
                                                keys[index],
                                                fontSize: Constant.mediumFont,
                                            ),
                                        ),
                                    ),
                                ),
                            );
 */