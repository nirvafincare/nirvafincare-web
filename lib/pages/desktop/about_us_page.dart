import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:resize/resize.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DesktopAboutUsPage extends ConsumerStatefulWidget {
  const DesktopAboutUsPage({super.key});

  @override
  ConsumerState<DesktopAboutUsPage> createState() => _DesktopAboutUsPageState();
}

class _DesktopAboutUsPageState extends ConsumerState<DesktopAboutUsPage>
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

      if (item != null &&
          item.itemLeadingEdge <= 0.7 &&
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
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
                fontSize: 40.sp,
              ),
            ),
          ),
          Gap(60.sp),
          SizedBox(
            width: context.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
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
                        height: context.width / 4.5,
                        width: context.width / 4.5,
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
                        width: context.width / 5,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Rutvi Chokshi Mehta, ',
                            style: TextStyle(
                              color: darkBlue,
                              fontFamily: 'gotham',
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: 'CA\n',
                                style: TextStyle(
                                  color: darkBlue,
                                  fontFamily: 'gotham',
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'Founder',
                                style: TextStyle(
                                  color: darkBlue,
                                  fontFamily: 'gotham',
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FadeTransition(
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
                      width: context.width / 1.8,
                      child: AutoSizeText(
                        founderText,
                        textAlign: TextAlign.center,
                        stepGranularity: 0.1,
                        style: TextStyle(
                          fontSize: 23.sp,
                        ),
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
