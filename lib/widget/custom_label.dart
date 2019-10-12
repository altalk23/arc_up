import 'dart:core';
import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
    CustomLabel(this.data, {this.fontSize});
    
    final String data;
    final double fontSize;
    
    @override
    Widget build(BuildContext context) {
        // TODO: implement label
        return Text(
            data,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                
            ),
        );
    }
}