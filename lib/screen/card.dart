import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:arc_up/card_list.dart';
import 'package:arc_up/screen/main.dart';
import 'package:arc_up/widget/custom_button.dart';
import 'package:flutter/services.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/widget/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:sensors/sensors.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tuple/tuple.dart';

class CardScreen extends StatefulWidget {
    CardScreen({Key key, this.type}) : super(key: key);
    final int type;
    
    @override
    _CardScreen createState() {
        return _CardScreen(type);
    }
}

class _CardScreen extends State<CardScreen> {
    Stopwatch stopwatch = Stopwatch();
    double lim = 9.5;
    List<StreamSubscription<dynamic>> _sub = <StreamSubscription<dynamic>>[];
    List<Tuple2<String, bool>> wordData = List<Tuple2<String, bool>>();
    Random random = new Random();
    String current;
    int score = 0;
    int _i = 0;
    int _countdown = 60;
    bool _tilted;
    Timer _timer;
    List<Color> gradient = [
        HSVColor.fromAHSV(1, 313, 0.40, 0.91).toColor(),
        HSVColor.fromAHSV(1, 313, 0.25, 0.96).toColor(),
    ];
    
    List<String> list;
    final int type;
    
    _CardScreen(this.type);
    
    @override
    void initState() {
        super.initState();
        _tilted = false;
        list = CardList.list[type].toList();
        list.shuffle();
        current = list[_i++];
        _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
            setState(() {
                _countdown--;
                if (_countdown <= 0) {
                    _dispose();
                    Navigator.pop(context, wordData);
                    timer.cancel();
                }
            });
        });
        _sub.add(accelerometerEvents.listen((AccelerometerEvent event) {
            setState(() {
                //print(event.toString());
                if (!_tilted) {
                    if (event.z > lim) {
                        _tilted = true;
                        wordData.add(Tuple2(current, true));
                        setState(() {
                            score++;
                            current = "Correct!";
                            gradient = [
                                HSVColor.fromAHSV(1, 121, 0.60, 0.91).toColor(),
                                HSVColor.fromAHSV(1, 121, 0.45, 0.96).toColor(),
                            ];
                        });
                    }
                    if (event.z < -lim) {
                        _tilted = true;
                        wordData.add(Tuple2(current, false));
                        setState(() {
                            current = "Pass!";
                            gradient = [
                                HSVColor.fromAHSV(1, 55, 0.60, 0.91).toColor(),
                                HSVColor.fromAHSV(1, 55, 0.45, 0.96).toColor(),
                            ];
                        });
                    }
                }
                else {
                    if (event.x > lim && lim - 14 < event.z && event.z < 14 - lim) {
                        _tilted = false;
                        setState(() {
                            current = list[_i++];
                            gradient = [
                                HSVColor.fromAHSV(1, 313, 0.40, 0.91).toColor(),
                                HSVColor.fromAHSV(1, 313, 0.25, 0.96).toColor(),
                            ];
                        });
                        
                        if (_i >= 49) {
                            _dispose();
                            Navigator.pop(context, wordData);
                            _timer.cancel();
                        }
                    }
                }
            });
        }));
        stopwatch.start();
    }
    
    @override
    void dispose() {
        super.dispose();
        _dispose();
    }
    
    void _dispose() {
        for (StreamSubscription<dynamic> subscription in _sub) {
            subscription.cancel();
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: gradient,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(75),
                        ),
                        border: Border.all(
                            color: Colors.white,
                            width: 20,
                            style: BorderStyle.solid,
                        ),
                    ),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                CustomLabel(
                                    _countdown.toString(),
                                    fontSize: Constant.largeFont,
                                ),
                                CustomLabel(
                                    current,
                                    fontSize: Constant.cardFont,
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}