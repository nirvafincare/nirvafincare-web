import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirvafincare/core/constants/app_theme.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/screens/home.dart';
import 'package:resize/resize.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size;

    if (context.isMobile) {
      size = const Size(410, 910);
    } else {
      size = const Size(1728, 1000);
    }

    return Resize(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nirva Fincare',
        theme: theme(context),
        home: const HomePage(),
      ),
      allowtextScaling: false,
      size: size,
    );
  }
}
