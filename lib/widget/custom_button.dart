import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomButton extends StatelessWidget {
    
    HSVColor hsvColor;
    final VoidCallback onPressed;
    final Widget child;
    final Color color;

    CustomButton({@required this.onPressed, this.child, this.color}) {
        if (color != null) {
            hsvColor = HSVColor.fromColor(color);
            hsvColor = HSVColor.fromAHSV(hsvColor.alpha, hsvColor.hue, hsvColor.saturation, hsvColor.value - 0.20);
        }
    }
    
    @override
    Widget build(BuildContext context) {
        // TODO: implement button
        return Container(
            decoration: ShapeDecoration(
                gradient: color == null ? LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [HSVColor.fromAHSV(1, 313, 0.90, 0.46).toColor(), HSVColor.fromAHSV(1, 313, 0.95, 0.57).toColor()]
                ) : LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [color, hsvColor.toColor()]
                ),
                shape: StadiumBorder(),
                
            ),
            child: RawMaterialButton(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    child: child,
                ),
                onPressed: onPressed,
                shape: StadiumBorder(),
            ),
        );
        /*return RawMaterialButton(
            child: child,
            fillColor: Colors.blue,
            splashColor: Colors.red,
            onPressed: onPressed,
            shape: StadiumBorder(),
        );*/
        /*return RaisedButton(
            onPressed: onPressed,
            child: child,
            color: color,
        );*/
    }
}