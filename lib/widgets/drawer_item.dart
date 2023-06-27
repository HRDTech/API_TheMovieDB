import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/constants.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Widget? child;
  final String? desc;

  const DrawerItem({super.key, required this.title, this.child, this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.0.w),
          child: Text(
            title,
            style: kBoldTitleTextStyle,
          ),
        ),
        Divider(
          color: kDrawerLineColor,
          height: 3.h,
          thickness: 0.1.h,
        ),
        child ??
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                desc!,
                style: kDrawerDescTextStyle,
              ),
            ),
      ],
    );
  }
}
