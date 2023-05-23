import 'package:flutter/material.dart';
import 'package:kit_chat_app/persenstation/view/home/view/home_page.dart';

enum MainItem {
  home,
  personal,
}

extension MainItemExtension on MainItem {
  Widget getScreen() {
    switch (this) {
      case MainItem.home:
        return const HomePage();

      case MainItem.personal:
        return const HomePage();
    }
  }

  int getIndex() {
    switch (this) {
      case MainItem.home:
        return 0;
      case MainItem.personal:
        return 1;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MainItem.home:
        return Icons.message;
      case MainItem.personal:
        return Icons.person;
    }
  }
}
