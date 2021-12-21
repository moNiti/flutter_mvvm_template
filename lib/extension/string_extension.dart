import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:template_app/view/toast_view.dart';

extension Toast on String {
  Future<void> showAsToast(BuildContext context,
      {required ToastStatus status}) async {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: ToastView(
        message: this,
        status: status,
        removeCustomToast: fToast.removeCustomToast,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}

extension Check on String? {
  bool isNullOrEmpty() {
    return this == null || (this != null && this!.isEmpty);
  }
}
