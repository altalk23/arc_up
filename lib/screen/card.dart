import 'dart:async';
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
    double aDZ;
    double lim = 8.5;
    List<StreamSubscription<dynamic>> _sub = <StreamSubscription<dynamic>>[];
    List<Tuple2<String, bool>> wordData = List<Tuple2<String, bool>>();
    Random random = new Random();
    String current;
    int score = 0;
    bool gDLock = false;
    Tween tween;
    int _i = 0;
    
    List<String> list;
    final int type;
    
    _CardScreen(this.type);
    
    @override
    void initState() {
        super.initState();
        list = CardList.list[type].toList();
        list.shuffle();
        current = list[_i];
        _sub.add(accelerometerEvents.listen((AccelerometerEvent event) {
            setState(() {
                aDZ = event.z;
                _switch();
            });
        }));
        stopwatch.start();
        Timer(Duration(minutes: 1), ()  {
            Navigator.pop(context, wordData);
        });
    }
    
    void _switch() {
        if (aDZ > lim && !gDLock) {
            _next();
        }
        else if (aDZ < -lim && !gDLock) {
            _skip();
        }
        else if (aDZ <= lim && aDZ >= -lim) gDLock = false;
        //TODO: nothing
    }
    
    void _next() {
        //TODO: next
        wordData.add(Tuple2(current, true));
        if (_i >= 49) {
            Navigator.pop(context, wordData);
        }
        else setState(() {
            current = list[++_i];
            score++;
            gDLock = true;
        });
    }
    
    void _skip() {
        //TODO: skip
        wordData.add(Tuple2(current, false));
        if (_i >= 49) {
            Navigator.pop(context, wordData);
        }
        else setState(() {
            current = list[++_i];
            gDLock = true;
        });
    }
    
    @override
    void dispose() {
        super.dispose();
        for (StreamSubscription<dynamic> subscription in _sub) {
            subscription.cancel();
        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: GradientAppBar(
                backgroundColorStart: HSVColor.fromAHSV(1, 313, 0.40, 0.10).toColor(),
                backgroundColorEnd: HSVColor.fromAHSV(1, 313, 0.25, 0.20).toColor(),
                title: CustomLabel(
                    "placeholder",
                    fontSize: Constant.titleFont,
                ),
            ),
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                            HSVColor.fromAHSV(1, 313, 0.40, 0.91).toColor(),
                            HSVColor.fromAHSV(1, 313, 0.25, 0.96).toColor(),
                        ],
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                    CustomButton(
                                        child: CustomLabel("next"),
                                        onPressed: _next,
                                    ),
                                    CustomButton(
                                        child: CustomLabel("skip"),
                                        onPressed: _skip,
                                    ),
                                ],
                            ),
                            CustomLabel(
                                current,
                                fontSize: Constant.cardFont,
                            ),
                            CustomLabel(
                                score.toString(),
                                fontSize: Constant.largeFont,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}