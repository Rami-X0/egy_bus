import 'dart:ui';

import 'package:flutter/material.dart';

class AppBlurDialog extends StatelessWidget {
 final Widget child;
  const AppBlurDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child:  child,
    );
  }
}
