import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:resize/resize.dart';

class MobileNavBar extends ConsumerStatefulWidget {
  const MobileNavBar({super.key});

  @override
  ConsumerState createState() => _MobileNavBarState();
}

class _MobileNavBarState extends ConsumerState<MobileNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> blurAnim;
  bool blur = false;
  bool drawerOpen = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 300.milliseconds,
    );
    blurAnim = Tween<double>(
      begin: 0,
      end: 10.sp,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
      ),
    );
    final listener = ref.read(positionListenerProvider);

    listener.itemPositions.addListener(() {
      final item = listener.itemPositions.value;
      if (!blur &&
          item.first.index == 0 &&
          item.first.itemTrailingEdge < 0.98) {
        blur = true;
        animationController.forward();
      } else if (blur &&
          item.first.index == 0 &&
          item.first.itemTrailingEdge > 0.98) {
        blur = false;
        animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: mobileAppBarHeight,
      child: Stack(
        children: [
          ClipRect(
            child: AnimatedBuilder(
              animation: blurAnim,
              builder: (_, __) => BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: blurAnim.value,
                  sigmaX: blurAnim.value,
                ),
                child: SizedBox(
                  width: context.width,
                  height: 60.sp,
                ),
              ),
            ),
          ),
          Container(
            height: mobileAppBarHeight,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: Scaffold.of(context).openDrawer,
                    child: SizedBox(
                      width: 40.sp,
                      child: Icon(
                        Icons.menu_rounded,
                        size: 30.sp,
                        color: darkBlue,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        logoAsset,
                        height: 35.sp,
                        width: 35.sp,
                        colorFilter: const ColorFilter.mode(
                          darkBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(10.sp),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            appName1.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            appName2.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(40.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
