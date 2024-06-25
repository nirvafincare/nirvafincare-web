import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/ui_provider.dart';
import 'package:resize/resize.dart';

class FollowMouse extends ConsumerWidget {
  const FollowMouse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = 60.sp;
    final screenSize = MediaQuery.of(context).size;
    double x = ref.watch(xProvider);
    double y = ref.watch(yProvider);
    bool visibility = ref.watch(visibilityProvider);

    //TODO: replace with compass svg
    return MouseRegion(
      opaque: false,
      onEnter: (event) {
        if (!visibility) {
          ref.read(visibilityProvider.notifier).update((_) => true);
          ref.read(xProvider.notifier).state = event.position.dx;
          ref.read(yProvider.notifier).state = event.position.dy;
        }
      },
      onExit: (event) {
        if (visibility) {
          ref.read(visibilityProvider.notifier).update((_) => false);
        }
      },
      onHover: (event) {
        ref.read(xProvider.notifier).state = event.position.dx;
        ref.read(yProvider.notifier).state = event.position.dy;
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          ref.read(xProvider.notifier).state = details.globalPosition.dx;
          ref.read(yProvider.notifier).state = details.globalPosition.dy;
        },
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            children: [
              Visibility(
                visible: visibility,
                child: AnimatedPositioned(
                  duration: 10.milliseconds,
                  top: y - 10,
                  left: x - (size / 2),
                  child: SvgPicture.asset(
                    pointerAsset,
                    height: size,
                    width: size,
                    // colorFilter: const ColorFilter.mode(
                    //   darkBlue,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
