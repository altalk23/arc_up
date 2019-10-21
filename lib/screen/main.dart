import 'dart:async';

import 'package:arc_up/card_list.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/screen/card.dart';
import 'package:arc_up/widget/custom_button.dart';
import 'package:arc_up/widget/custom_label.dart';
import 'package:arc_up/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

Future<List<Tuple2<String, bool>>> wordData;

class MainScreen extends StatefulWidget {
    MainScreen({Key key}) : super(key: key);
    
    @override
    _MainScreen createState() {
        return _MainScreen();
    }
}

class _MainScreen extends State<MainScreen> {
    bool _absorb = false;
    
    @override
    Widget build(BuildContext context) {
        return CustomScaffold(
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                                return SimpleDialog(
                                    backgroundColor: Color(0x00000000),
                                    title: CustomLabel(
                                        "Help",
                                        fontSize: Constant.largeFont,
                                    ),
                                    children: <Widget>[
                                        Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur euismod ullamcorper dolor, ut interdum mauris elementum sit amet."
                                                    " Vivamus dictum molestie nulla a bibendum. Nulla pretium, sapien eget mollis ullamcorper, velit nulla pulvinar tellus, vitae sollicitudin tortor sem et leo. Vestibulum feugiat vel dui non malesuada. Aliquam varius lectus id tellus tincidunt, at tempus nulla tempor. Sed lacinia convallis sem non congue. Vestibulum eget ligula vitae quam pretium posuere nec et ante. Vivamus id leo ut risus pellentesque ultrices. Praesent sapien nisl, sollicitudin a ultricies et, elementum ut velit. Nulla ex mauris, posuere id posuere vel, auctor sit amet sem.",
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
                )
            ],
            title: "placeholder",
            child: Container(
                child: AbsorbPointer(
                    absorbing: _absorb,
                    child: Column(
                        children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(Constant.largePadding),
                                child: ListTile(
                                    title: CustomLabel(
                                        CardList.type[0],
                                        fontSize: Constant.largeFont,
                                    ),
                                    onTap: () {
                                        wordData = null;
                                        wordData = Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                    return CardScreen(type: 0);
                                                },
                                            ),
                                        );
                                        setState(() {
                                            _absorb = true;
                                        });
                                    },
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(Constant.largePadding),
                                child: ListTile(
                                    title: CustomLabel(
                                        CardList.type[1],
                                        fontSize: Constant.largeFont,
                                    ),
                                    onTap: () {
                                        wordData = null;
                                        wordData = Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                    return CardScreen(type: 1);
                                                },
                                            ),
                                        );
                                    },
                                ),
                            ),
                            Expanded(
                                child: FutureBuilder(
                                    future: wordData,
                                    builder: (context, snap) {
                                        return snap.hasData ? ListView.separated(
                                            itemBuilder: (context, index) {
                                                return Container(
                                                    color: snap.data[index].item2 ? Colors.lightGreen : Colors.red,
                                                    child: ListTile(
                                                        title: CustomLabel(
                                                            snap.data[index].item1,
                                                            fontSize: Constant.mediumFont,
                                                        ),
                                                    ),
                                                );
                                            },
                                            separatorBuilder: (context, index) {
                                                return Divider();
                                            },
                                            itemCount: snap.data.length,
                                        ) : Container();
                                    },
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
