import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget{
  final String text;
  final Function onPressed;
  AdaptiveFlatButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context){
    return Platform.isIOS ? CupertinoButton(child: Text(text), onPressed: onPressed) : TextButton(child: Text(text), onPressed: onPressed);
  }
}

class AdaptiveElevatedButton extends StatelessWidget{
  final String text;
  final Function onPressed;
  AdaptiveElevatedButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context){
    return Platform.isIOS ? CupertinoButton(child: Text(text), onPressed: onPressed, color: Theme.of(context).primaryColor) : ElevatedButton(child: Text(text), onPressed: onPressed);
  }
}