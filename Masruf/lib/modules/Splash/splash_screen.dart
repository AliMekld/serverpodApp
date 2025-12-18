import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallet.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/extensions.dart';

import '../../utilities/constants/assets.dart';
import '../Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routerName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed(HomeScreen.routerName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            SvgPicture.asset(
              Assets.imagesAppLogo,
              width: 240.r,
              height: 240.r,
            ),
            16.0.heightBox,
            Text(
              Strings.appName.tr.toUpperCase(),
              style: TextStyle(
                fontFamily: Constants.notoSansKoufyFontFamily,
                // letterSpacing: 8,
                color: ColorsPalette.of(context).primaryColor,
                fontSize: 24,
              ),
            ),
            16.h.heightBox,
            CircularProgressIndicator(
              color: ColorsPalette.of(context).primaryColor,
              strokeWidth: 6.r,
              strokeAlign: 0.2.r,
              strokeCap: StrokeCap.round,
            ),
            const Spacer(),
            Text(
              'version 1.0'.toUpperCase(),
              style: TextStyle(
                fontFamily: Constants.agbalumoFontFamily,
                letterSpacing: 4,
                fontWeight: FontWeight.normal,
                color: ColorsPalette.of(context).primaryColor,
                fontSize: 8.r,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
