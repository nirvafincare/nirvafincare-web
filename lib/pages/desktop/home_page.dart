import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:resize/resize.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 1000.milliseconds,
    );
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => animationController.forward(),
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
    return Container(
      height: context.height - desktopAppBarHeight,
      width: context.width,
      margin: EdgeInsets.only(top: desktopAppBarHeight),
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.width,
            padding: EdgeInsets.symmetric(vertical:40.sp),
            color: lightBlue,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0,
                        0.6,
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    logoAsset,
                    height: context.width / 4.5,
                    width: context.width / 4.5,
                    colorFilter: const ColorFilter.mode(
                      beige,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Gap(context.width / 20),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0,
                        0.6,
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${appName1.toUpperCase()} ${appName2.toUpperCase()}',
                        style: TextStyle(
                          // fontFamily: 'gotham',
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w800,
                          color: beige,
                        ),
                      ),
                      Text(
                        tagline,
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.normal,
                          color: beige,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0.4,
                        0.8,
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  child: Text(
                    homeTitleText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40.sp,
                    ),
                  ),
                ),
                Gap(20.sp),
                FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(
                        0.6,
                        1,
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: context.width / 1.2,
                    child: Text(
                      missionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
