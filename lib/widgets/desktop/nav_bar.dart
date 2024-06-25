import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/nav_provider.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:resize/resize.dart';

class DesktopNavBar extends ConsumerStatefulWidget {
  const DesktopNavBar({super.key});

  @override
  ConsumerState<DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends ConsumerState<DesktopNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> blurAnim;
  bool blur = false;

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
    return Container(
      width: context.width,
      height: desktopAppBarHeight,
      alignment: Alignment.center,
      color: Colors.transparent,
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
                  height: 80.sp,
                ),
              ),
            ),
          ),
          Container(
            height: desktopAppBarHeight,
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  logoAsset,
                  height: 60.sp,
                  width: 60.sp,
                  colorFilter: const ColorFilter.mode(
                    darkBlue,
                    BlendMode.srcIn,
                  ),
                ),
                Gap(15.sp),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      appName1.toUpperCase(),
                      style: TextStyle(
                        fontSize: context.width/90,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      appName2.toUpperCase(),
                      style: TextStyle(
                        fontSize: context.width/90,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gap(context.width / 15),
                ...navMenu.map((item) => NavItem(
                      title: item,
                      index: navMenu.indexOf(item),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends ConsumerStatefulWidget {
  const NavItem({
    super.key,
    required this.title,
    required this.index,
  });

  final String title;

  final int index;

  @override
  ConsumerState createState() => _NavItemState();
}

class _NavItemState extends ConsumerState<NavItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 300.milliseconds,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currIndex = ref.watch(navIndexProvider);

    if (currIndex == widget.index) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    return MouseRegion(
      onEnter: (mouse) {
        if (currIndex != widget.index) {
          animationController.forward();
        }
      },
      onExit: (mouse) {
        if (currIndex != widget.index) {
          animationController.reverse();
        }
      },
      child: GestureDetector(
        onTap: () => updatePage(
          ref,
          widget.index,
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 50.sp,
          width: context.width / 15,
          margin: EdgeInsets.symmetric(horizontal: 15.sp),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: context.width/100,
                      fontWeight: currIndex != widget.index
                          ? FontWeight.normal
                          : FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Curves.bounceInOut,
                    ),
                  ),
                  child: Container(
                    width: context.width / 15,
                    height: 4.sp,
                    decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(2.sp),
                      ),
                    ),
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
