// This file contains constants we want to re-use throughout the app.
// For example, shared input decoration properties for form fields

import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white,
            width:2.0
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black,
            width:2.0
        )
    )
);