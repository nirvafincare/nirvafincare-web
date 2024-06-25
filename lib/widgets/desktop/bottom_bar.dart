import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopBottomBar extends StatelessWidget {
  const DesktopBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(60.sp),
        SizedBox(
          width: context.width / 1.05,
          child: Text(
            companyDetailsText,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
          ),
        ),
        SizedBox(
          width: context.width / 1.05,
          child: Text(
            disclaimerText,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
          ),
        ),
        Gap(20.sp),
        Flexible(
          child: Container(
            width: context.width,
            color: darkBlue.withOpacity(0.6),
            padding: EdgeInsets.only(
              right: 20.sp,
              left: 20.sp,
              top: 30.sp,
              bottom: 10.sp,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 30.sp,
                            color: beige,
                          ),
                          Gap(10.sp),
                          SelectableText(
                            addressText,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: beige,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.sp),
                      GestureDetector(
                        onTap: () => launchUrl(emailPrimary.mailTo),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 30.sp,
                              color: beige,
                            ),
                            Gap(10.sp),
                            SelectableText(
                              emailPrimary,
                              onTap: () => launchUrl(emailPrimary.mailTo),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: beige,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.sp),
                      GestureDetector(
                        onTap: () => launchUrl(emailSecondary.mailTo),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 30.sp,
                              color: beige,
                            ),
                            Gap(10.sp),
                            SelectableText(
                              emailSecondary,
                              onTap: () => launchUrl(emailSecondary.mailTo),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: beige,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.sp),
                      GestureDetector(
                        onTap: () => launchUrl(Uri.parse(phoneUrl)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 30.sp,
                              color: beige,
                            ),
                            Gap(10.sp),
                            SelectableText(
                              phoneText,
                              onTap: () => launchUrl(Uri.parse(phoneUrl)),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: beige,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(30.sp),
                Container(
                  alignment: Alignment.center,
                  width: context.width,
                  child: Text(
                    bottomBarText,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: beige,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
