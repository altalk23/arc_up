import 'package:arc_up/screen/card.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                fontFamily: 'Nunito',
            ),
            home: CardScreen(),
        );
    }
}