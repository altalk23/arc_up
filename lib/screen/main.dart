import 'dart:async';

import 'package:arc_up/card_list.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/screen/card.dart';
import 'package:arc_up/screen/word.dart';
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
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
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
                                        "Yardım",
                                        fontSize: Constant.largeFont,
                                    ),
                                    children: <Widget>[
                                        Text(
                                            'Başlamak için kategori seç.\n'
                                              'Telefonu alnına yerleştirmen lazım.\n'
                                              'Arkadaşların gösterilen kelimeyi sana anlatacaklar.\n'
                                              'Doğru bilirsen yukarı eğ.\n'
                                              'Pas geçmek için aşağı eğ.\n'
                                              '1 dakika sonra oyun biter.\n'
                                              'Tekrar oynayabilir ve kelime listesine bakabilirsin.\n'
                                              'Bir kelimeye basınca açıklamasına bakabilirsin.\n'
                                              'İyi eğlenceler!',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Constant.helpFont,
                                            ),
                                        )
                                    ],
                                );
                            },
                        );
                    },
                )
            ],
            title: "Ana Ekran",
            child: Container(
                child: Row(
                    children: <Widget>[
                        Expanded(
                            flex: 6,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(Constant.padding),
                                        child: CustomButton(
                                            child: CustomLabel(
                                                CardList.type[0],
                                                fontSize: Constant.largeFont,
                                            ),
                                            onPressed: () {
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
                                        padding: const EdgeInsets.all(Constant.padding),
                                        child: CustomButton(
                                            child: CustomLabel(
                                                CardList.type[1],
                                                fontSize: Constant.largeFont,
                                            ),
                                            onPressed: () {
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
                                    Padding(
                                        padding: const EdgeInsets.all(Constant.padding),
                                        child: CustomButton(
                                            child: CustomLabel(
                                                "Kelimeler",
                                                fontSize: Constant.largeFont,
                                            ),
                                            onPressed: () {
                                                wordData = null;
                                                wordData = Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                            return WordScreen();
                                                        },
                                                    ),
                                                );
                                            },
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Expanded(
                            flex: 9,
                            child: FutureBuilder(
                                future: wordData,
                                builder: (context, snap) {
                                    return snap.hasData ? ListView.separated(
                                        itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                            return SimpleDialog(
                                                                backgroundColor: Color(0x00000000),
                                                                title: CustomLabel(
                                                                    snap.data[index].item1,
                                                                    fontSize: Constant.largeFont,
                                                                ),
                                                                children: <Widget>[
                                                                    Text(
                                                                        CardList.exp[snap.data[index].item1],
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
                                                child: Container(
                                                    decoration: ShapeDecoration(
                                                        shape: StadiumBorder(),
                                                        gradient: LinearGradient(
                                                            begin: Alignment.bottomLeft,
                                                            end: Alignment.topRight,
                                                            colors: snap.data[index].item2 ? [
                                                                HSVColor.fromAHSV(1, 121, 0.80, 0.91).toColor(),
                                                                HSVColor.fromAHSV(1, 121, 0.65, 0.96).toColor(),
                                                            ] : [
                                                                HSVColor.fromAHSV(1, 1, 0.80, 0.91).toColor(),
                                                                HSVColor.fromAHSV(1, 1, 0.65, 0.96).toColor(),
                                                            ],
                                                        ),
                                                    ),
                                                    child: ListTile(
                                                        title: CustomLabel(
                                                            snap.data[index].item1,
                                                            fontSize: Constant.mediumFont,
                                                        ),
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
        );
    }
}
