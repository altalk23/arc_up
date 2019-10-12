import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomCheckbox extends StatelessWidget {
    CustomCheckbox({this.value, this.onChanged});
    
    final bool value;
    final VoidCallback onChanged;
    
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: ShapeDecoration(
                gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [HSVColor.fromAHSV(1, 313, 0.90, 0.46).toColor(), HSVColor.fromAHSV(1, 313, 0.95, 0.57).toColor()]
                ),
                shape: CircleBorder(),
            ),
            child: RawMaterialButton(
                child: value ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30.0,
                ) : null,
                onPressed: onChanged,
                shape: CircleBorder(),
            ),
        );
    }
    
    
}
