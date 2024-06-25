import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:resize/resize.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MobileAboutUsPage extends ConsumerStatefulWidget {
  const MobileAboutUsPage({super.key});

  @override
  ConsumerState createState() => _MobileAboutUsPageState();
}

class _MobileAboutUsPageState extends ConsumerState<MobileAboutUsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 1.seconds,
    );

    final listener = ref.read(positionListenerProvider);

    listener.itemPositions.addListener(() {
      ItemPosition? item;

      for (var position in listener.itemPositions.value) {
        if (position.index == aboutUsIndex) {
          item = position;
        }
      }

      if (item != null && item.itemLeadingEdge <= 0.7 &&
          !animationController.isAnimating &&
          !animationController.isCompleted) {
        animationController.forward();
      }
    });
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
      width: context.width,
      margin: EdgeInsets.only(top: desktopAppBarHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval(
                  0,
                  0.3,
                  curve: Curves.easeIn,
                ),
              ),
            ),
            child: Text(
              aboutUsTitleText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Gap(40.sp),
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval(
                  0,
                  0.5,
                  curve: Curves.easeIn,
                ),
              ),
            ),
            child: Image.asset(
              photoAsset,
              height: context.height / 2.5,
              width: context.height / 2.5,
              fit: BoxFit.cover,
            ),
          ),
          Gap(20.sp),
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval(
                  0.3,
                  0.7,
                  curve: Curves.easeIn,
                ),
              ),
            ),
            child: SizedBox(
              width: context.width / 1.2,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Rutvi Chokshi Mehta, ',
                  style: TextStyle(
                    color: darkBlue,
                    fontFamily: 'gotham',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'CA\n',
                      style: TextStyle(
                        color: darkBlue,
                        fontFamily: 'gotham',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Founder',
                      style: TextStyle(
                        color: darkBlue,
                        fontFamily: 'gotham',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(15.sp),
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval(
                  0.5,
                  1,
                  curve: Curves.easeIn,
                ),
              ),
            ),
            child: SizedBox(
              width: context.width / 1.1,
              child: Text(
                founderText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
