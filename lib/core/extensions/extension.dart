import 'package:flutter/material.dart';

extension FormKeyExtension on GlobalKey<FormState> {
  bool isValid() {
    return  currentState?.validate() ?? false;
  }
}
