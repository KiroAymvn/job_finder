import 'package:flutter/material.dart';

import '../../core/utils/text_styles.dart';


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessengerError(
    BuildContext context,
    String errorMessage,
    {Color?color}
    ) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      padding: EdgeInsetsGeometry.all(8),
      margin: EdgeInsets.all(50),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.none,
      content: Text(errorMessage,style: Styles.mediumTitle,),
      backgroundColor: color?? Colors.red,
    ),
  );
}