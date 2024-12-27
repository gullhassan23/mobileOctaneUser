import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerDisposer<T extends GetxController> extends StatefulWidget {
  final T controller;
  final Widget child;

  const ControllerDisposer({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  _ControllerDisposerState<T> createState() => _ControllerDisposerState<T>();
}

class _ControllerDisposerState<T extends GetxController>
    extends State<ControllerDisposer<T>> {
  @override
  void dispose() {
    Get.delete<T>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
