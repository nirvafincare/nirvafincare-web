import 'package:flutter/widgets.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/widgets/desktop/custom_scaffold.dart';
import 'package:nirvafincare/widgets/mobile/custom_scaffold.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? MobileScaffold(
            child: child,
          )
        : DesktopScaffold(
            child: child,
          );
  }
}
