import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../constant.dart';
import 'custom_label.dart';

class CustomScaffold extends StatelessWidget {
    
    final String title;
    final List<Widget> actions;
    final Widget child;
    
    const CustomScaffold({Key key, this.title, this.actions, this.child}) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: GradientAppBar(
                backgroundColorStart: HSVColor.fromAHSV(1, 313, 0.40, 0.10).toColor(),
                backgroundColorEnd: HSVColor.fromAHSV(1, 313, 0.25, 0.20).toColor(),
                title: CustomLabel(
                    title,
                    fontSize: Constant.titleFont,
                ),
                actions: actions,
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
                ),
                child: child,
            ),
        );
    }
    
}