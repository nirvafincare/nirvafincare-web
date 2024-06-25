import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/nav_provider.dart';
import 'package:nirvafincare/widgets/mobile/nav_bar.dart';
import 'package:resize/resize.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Consumer(builder: (_, ref, __) {
        final navIndex = ref.watch(navIndexProvider);

        return Drawer(
          width: context.width / 1.6,
          backgroundColor: darkBlue,
          child: Container(
            padding: EdgeInsets.all(15.sp),
            height: context.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Icon(
                    Icons.close_rounded,
                    size: 35.sp,
                    color: beige,
                  ),
                ),
                Gap(20.sp),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: navMenu
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              updatePage(ref, navMenu.indexOf(e));
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.sp),
                              width: context.width,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: navIndex == navMenu.indexOf(e)
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: navIndex == navMenu.indexOf(e)
                                      ? beige
                                      : beige.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      body: Stack(
        children: [
          child,
          const MobileNavBar(),
        ],
      ),
    );
  }
}
