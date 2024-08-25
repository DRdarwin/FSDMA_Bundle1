import 'package:flutter/material.dart' show BuildContext, StatelessWidget, Widget;

class NavigationScreenMobile extends StatelessWidget {
  final Widget child;

  const NavigationScreenMobile({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
