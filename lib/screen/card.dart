import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:arc_up/constant.dart';
import 'package:arc_up/widget/custom_label.dart';
import 'package:arc_up/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:sensors/sensors.dart';

class CardScreen extends StatefulWidget {
    CardScreen({Key key}) : super(key: key);
    
    @override
    _CardScreen createState() {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
        return _CardScreen();
    }
}

class _CardScreen extends State<CardScreen> {
    List<double> _aV;
    double aDY;
    double lim = 7;
    List<StreamSubscription<dynamic>> _sub = <StreamSubscription<dynamic>>[];
    Random random = new Random();
    String current;
    int score = 0;
    bool gDLock = false;
    
    List<String> test = [
        "sample text 1",
        "sample text 2",
        "sample text 3",
        "sample text 4",
        "sample text 5",
        "sample text 6",
        "sample text 7",
        "sample text 8",
    ];
    
    @override
    void initState() {
        super.initState();
        current = test[0];
        _sub.add(accelerometerEvents.listen((AccelerometerEvent event) {
            setState(() {
                _aV = <double>[event.x, event.y, event.z];
                aDY = _aV[2];
                _next();
            });
        }));
    }
    
    void _next() {
        if (aDY > lim && !gDLock) {
            print(gDLock);
            //TODO: next
            current = test[random.nextInt(test.length)];
            score++;
            gDLock = true;
        }
        else if (aDY < -lim && !gDLock) {
            //TODO: skip
            current = test[random.nextInt(test.length)];
            gDLock = true;
        }
        else if (aDY <= lim && aDY >= -lim) gDLock = false;
        //TODO: nothing
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
                            CustomLabel(
                                current,
                                fontSize: Constant.cardFont,
                            ),
                            CustomLabel(
                                score.toString(),
                                fontSize: Constant.largeFont,
                            )
                        ],
                    ),
                    /*child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Container(
                            color: gDY > lim ? Colors.red : gDY < -lim ? Colors.blue : Colors.transparent,
                        ),
                    ),*/
                ),
            ),
        );
        return CustomScaffold(
            title: "placeholder",
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50),
                        ),
                        border: Border.all(
                            color: Colors.white,
                            width: 15,
                            style: BorderStyle.solid,
                        ),
                    ),
                ),
            ),
        );
    }
}

/*
Column(
    children: <Widget>[
        CustomLabel(
            gDY.round().toString(),
            fontSize: Constant.largeFont,
        ),
        SizedBox(
            width: 300,
            height: 300,
            child: Container(
                color: gDY > lim ? Colors.red : gDY < -lim ? Colors.blue : Colors.transparent,
            ),
        ),
    ],
)
)

 */

/*
Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            Padding(
                child: CustomLabel(
                    '∆x${_aV[0]~/1}\n∆y${_aV[1]~/1}\n∆z${_aV[2]~/1}',
                    fontSize: Constant.mediumFont,
                ),
                padding: const EdgeInsets.all(16.0),
            ),
            Padding(
                child: CustomLabel(
                    '∆x${_gV[0]~/1}\n∆y${_gV[1]~/1}\n∆z${_gV[2]~/1}',
                    fontSize: Constant.mediumFont,
                ),
                padding: const EdgeInsets.all(16.0),
            ),
            Padding(
                child: CustomLabel(
                    '∆x${_uAV[0]~/1}\n∆y${_uAV[1]~/1}\n∆z${_uAV[2]~/1}',
                    fontSize: Constant.mediumFont,
                ),
                padding: const EdgeInsets.all(16.0),
            ),
        ],
    ),
),
 */