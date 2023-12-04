import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {

  Size deviceSize() {
    return MediaQuery.of(this).size;
  }
}
