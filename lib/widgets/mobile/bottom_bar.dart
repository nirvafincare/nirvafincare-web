import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';
import 'package:nirvafincare/core/constants/app_constants.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileBottomBar extends StatelessWidget {
  const MobileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(40.sp),
        SizedBox(
          width: context.width / 1.05,
          child: Text(
            companyDetailsText,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ),
        Gap(5.sp),
        SizedBox(
          width: context.width / 1.05,
          child: Text(
            disclaimerText,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ),
        Gap(10.sp),
        Container(
          width: context.width,
          height: context.height / 5,
          color: darkBlue,
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
            vertical: 10.sp,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
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
                          size: 15.sp,
                          color: beige,
                        ),
                        Gap(5.sp),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SelectableText(
                              addressText,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: beige,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async => await launchUrl(emailPrimary.mailTo),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 15.sp,
                            color: beige,
                          ),
                          Gap(5.sp),
                          SelectableText(
                            emailPrimary,
                            onTap: () async =>
                                await launchUrl(emailPrimary.mailTo),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: beige,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async => await launchUrl(emailSecondary.mailTo),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 15.sp,
                            color: beige,
                          ),
                          Gap(5.sp),
                          SelectableText(
                            emailSecondary,
                            onTap: () async =>
                                await launchUrl(emailSecondary.mailTo),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: beige,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async => await launchUrl(Uri.parse(phoneUrl)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: 15.sp,
                            color: beige,
                          ),
                          Gap(5.sp),
                          SelectableText(
                            phoneText,
                            onTap: () async =>
                                await launchUrl(Uri.parse(phoneUrl)),
                            style: TextStyle(
                              fontSize: 12.sp,
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
              Container(
                alignment: Alignment.center,
                width: context.width,
                child: Text(
                  bottomBarText,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: beige,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
