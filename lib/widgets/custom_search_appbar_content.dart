import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/constants.dart';

class CustomSearchAppbarContent extends StatelessWidget {
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;

  const CustomSearchAppbarContent({super.key, this.onChanged, this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0.h,
      color: kAppBarColor,
      child: Center(
        child: ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            style: kDrawerDescTextStyle,
            cursorColor: Colors.white,
            autofocus: true,
            autocorrect: false,
            textInputAction: TextInputAction.search,
            decoration: kTextFieldDecoration,
          ),
          trailing: IconButton(
            splashRadius: 2.sp,
            icon: const Icon(Icons.keyboard_voice),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
