import 'package:flutter/material.dart';

extension Rounder on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension Validate on String? {
  bool validateRequired() {
    if (this == null || this!.isEmpty) return false;
    return true;
  }
}

extension NavigateWithMaterialPageRoute on NavigatorState {
  pushReplacementMaterial(Widget page) {
    pushReplacement(MaterialPageRoute(builder: (newContext) {
      return page;
    }));
  }
}
