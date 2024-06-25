import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:resize/resize.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MobileProductsPage extends ConsumerStatefulWidget {
  const MobileProductsPage({super.key});

  @override
  ConsumerState<MobileProductsPage> createState() => _MobileProductsPageState();
}

class _MobileProductsPageState extends ConsumerState<MobileProductsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: 2000.milliseconds,
    );

    final listener = ref.read(positionListenerProvider);

    listener.itemPositions.addListener(() {
      ItemPosition? item;

      for (var position in listener.itemPositions.value) {
        if (position.index == productsIndex) {
          item = position;
        }
      }

      if (item != null &&
          item.itemLeadingEdge <= 0.8 &&
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
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            productsTitleText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          Gap(40.sp),
          // ...products.map((product) => productItems(products.indexOf(product)))
          ...buildChildren(),
        ],
      ),
    );
  }

  List<Widget> buildChildren() {
    double begin = 0;
    final interval = (2000 / products.length).remap(0, 2000, 0, 1);
    final releaseBefore = interval / products.length;
    final list = <Widget>[];

    for (var index = 0; index < products.length; index++) {
      list.add(
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval(
                begin,
                begin + interval,
                curve: Curves.easeIn,
              ),
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  begin,
                  begin + interval,
                  curve: Curves.easeIn,
                ),
              ),
            ),
            child: productItems(index),
          ),
        ),
      );
      begin += interval - releaseBefore;
    }

    return list;
  }

  Widget productItems(int index) {
    return Container(
      margin: EdgeInsets.only(
        right: 25.sp,
        left: 25,
        bottom: 25.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.sp),
        color: lightBlue.withOpacity(0.2),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(10.sp),
          SvgPicture.asset(
            productIcons[index],
            height: 40.sp,
            width: 40.sp,
            colorFilter: const ColorFilter.mode(
              darkBlue,
              BlendMode.srcIn,
            ),
          ),
          Gap(15.sp),
          Text(
            products[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          Gap(15.sp),
          AutoSizeText(
            productDescription[index],
            textAlign: TextAlign.center,
            stepGranularity: 0.1,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
