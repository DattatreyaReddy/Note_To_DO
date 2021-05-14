import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  labelText: 'Enter the value',
  alignLabelWithHint: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  errorStyle: TextStyle(),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
  ),
);
