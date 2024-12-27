import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_animate/flutter_animate.dart";

import '../views/Constrants/Colors.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;
  final bool isbackdrop;
  final Color? color;

  const LoadingWidget(
      {Key? key, this.isImage = false, this.isbackdrop = true, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isbackdrop
        ? Center(
            child: _buildBody(context),
          )
        : Stack(
            children: [
              // Background with backdrop blur

              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2), // Adjust the blur intensity as needed
                  child: Container(
                    color: Colors.transparent, // Adjust the opacity as needed
                  ),
                ),
              ),
              Center(
                child: _buildBody(context),
              ).animate().fadeIn(
                    duration: 600.ms,
                  ),
            ],
          );
  }

  Widget _buildBody(BuildContext context) {
    if (isImage) {
      return SpinKitRipple(
        color: color ?? AppColors.backgroundColor,
      );
    } else {
      return SpinKitThreeBounce(
        size: 30,
        color: color ?? AppColors.Button1,
      );
    }
  }
}
