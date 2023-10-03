import 'package:flutter/material.dart';


class ScreenContent {
  final String selectedItem;
  final Map<String, Widget Function()> screenCases;

  ScreenContent(this.selectedItem, this.screenCases);

  Widget renderSelectedWidget() {
    if (screenCases.containsKey(selectedItem)) {
      return screenCases[selectedItem]!();
    } else {
      return SizedBox.shrink();
    }
  }
}
