import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:brain_teaser/util/constant.dart';
import 'package:flutter/material.dart';

buildDialog(
    BuildContext context,
    String title,
    String message,
    DialogType dialogType,
    GestureTapCallback onTapOk,
    GestureTapCallback onTapCancel) {
  return AwesomeDialog(
          context: context,
          dialogType: dialogType,
          animType: AnimType.BOTTOMSLIDE,
          title: title,
          btnOkColor: kItemSelectBottomNav,
          desc: message,
          btnCancelOnPress: onTapCancel,
          btnOkOnPress: onTapOk)
      .show();
}
