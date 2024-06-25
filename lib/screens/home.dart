import 'package:flutter/material.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/screens/desktop/home.dart';
import 'package:nirvafincare/screens/mobile/home.dart';
import 'package:nirvafincare/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      child: context.isMobile
          ? const MobileHome()
          : const DesktopHome(),
    );
  }
}
