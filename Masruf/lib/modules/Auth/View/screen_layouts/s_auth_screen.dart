import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/Language/language_provider.dart';
import '../../../../../core/theme/color_pallet.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/extensions.dart';
import '../../Controller/auth_bloc.dart';
import '../widgets/login_part.dart';
import '../widgets/register_part.dart';

class SmallAuthScreen extends StatelessWidget {
  const SmallAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
      final bloc = context.read<AuthBloc>();
      return Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(
            color: ColorsPalette.of(context).backgroundColor,
          ),
          Form(
            key: bloc.formKey,
            child: Container(
              decoration: BoxDecoration(
                color: ColorsPalette.of(context)
                    .secondaryColor
                    .withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: ColorsPalette.of(context)
                        .secondaryTextColor
                        .withValues(alpha: 0.4),
                    spreadRadius: 4,
                    blurRadius: 4,
                  ),
                ],
                borderRadius: BorderRadius.circular(16.r),
              ),
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                SvgPicture.asset(
                  Assets.imagesAppLogo,
                  width: 120.r,
                  height: 120.r,
                ),
                18.h.heightBox,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.isLogin != current.isLogin,
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: state.isLogin
                          ? const LoginPart(key: ValueKey('login'))
                          : const RegiserPart(key: ValueKey('register')),
                    );
                  },
                ),
              ]).withVerticalScroll,
            ),
          ),
        ],
      ));
    });
  }
}
