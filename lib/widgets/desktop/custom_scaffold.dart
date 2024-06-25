import 'package:flutter/material.dart';
import 'package:nirvafincare/widgets/desktop/follow_mouse.dart';
import 'package:nirvafincare/widgets/desktop/nav_bar.dart';

class DesktopScaffold extends StatelessWidget {
  const DesktopScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MouseRegion(
            opaque: false,
            cursor: SystemMouseCursors.none,
            child: Stack(
              children: [
                child,
                const DesktopNavBar(),
              ],
            ),
          ),
          const FollowMouse(),
        ],
      ),
    );
  }
}
