// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utilities/extensions.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingWidget({super.key, this.isLoading = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
            children: [
              child,
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade400 .withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(16.r)),
                child: const CircularProgressIndicator(
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                ),
              ).center,
            ],
          )
        : child;
  }
}
