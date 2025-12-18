import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/Language/app_localization.dart';
import '../../../../../utilities/extensions.dart';

import '../../../../../core/theme/color_pallet.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../utilities/constants/Strings.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/validator.dart';
import '../../../../../widgets/custom_text_field_widget.dart';
import '../../../../../widgets/cutom_button_widget.dart';
import '../../Controller/auth_bloc.dart';

class LoginPart extends StatelessWidget {
  const LoginPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = context.read<AuthBloc>();
        return Column(
          children: [
            Text(
              Strings.welcomeBack.tr,
              style: TextStyleHelper.of(context).headlinelarge32R.copyWith(
                    color: ColorsPalette.of(context).buttonColor,
                  ),
            ),
            18.h.heightBox,
            Text(
              Strings.login.tr,
              style: TextStyleHelper.of(context).titleLarge22R,
            ),
            18.h.heightBox,
            CustomTextFieldWidget(
              errorText: state.errorMessage?.contains('email') == true
                  ? state.errorMessage
                  : null,
              textInputType: TextInputType.emailAddress,
              validator: (v) => Validator.validateEmail(v!),
              lableText: Strings.email.tr,
              controller: bloc.emailController,
            ),
            18.h.heightBox,
            CustomTextFieldWidget(
              errorText: state.errorMessage?.contains('password') == true
                  ? state.errorMessage
                  : null,
              textInputType: TextInputType.visiblePassword,
              validator: (v) => Validator.validatePassword(v!),
              lableText: Strings.password.tr,
              controller: bloc.passwordController,
            ),
            18.h.heightBox,
            TextButton(
              onPressed: () {},
              child: Text(Strings.forgetPassword.tr,
                  style: TextStyleHelper.of(context).bodySmall12R),
            ),
            18.h.heightBox,
            CustomButtonWidget.primary(
              width: 320.w,
              context: context,
              onTap: () => bloc.add(LoginEvent(context)),
              buttonTitle: Strings.login.tr,
              isLoading: state.isLoading,
            ),
            18.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  color: ColorsPalette.of(context).primaryTextColor,
                  thickness: 0.2,
                  height: 0,
                ).expand,
                Text(Strings.or.tr,
                    style: TextStyleHelper.of(context).bodyMedium14R.copyWith(
                          color: ColorsPalette.of(context).primaryTextColor,
                        )).addPaddingHorizontal(padding: 4),
                Divider(
                  color: ColorsPalette.of(context).primaryTextColor,
                  thickness: 0.2,
                  height: 0,
                ).expand,
              ],
            ),
            18.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.facebook,
                      size: 32.r,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      Assets.imagesGoogle,
                      width: 32.w,
                      height: 32.h,
                    )),
              ],
            ).widthBox(200),
            18.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Strings.dontHaveAccount.tr,
                    style: TextStyleHelper.of(context).bodyMedium14R.copyWith(
                          color: ColorsPalette.of(context).primaryTextColor,
                        )),
                TextButton(
                  onPressed: () {
                    bloc.add(ToggleAuthModeEvent());
                  },
                  child: Text(Strings.registerNow.tr,
                      style: TextStyleHelper.of(context).bodyMedium14R),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
