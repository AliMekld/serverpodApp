import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../core/Language/app_localization.dart';
import '../core/theme/color_pallet.dart';
import '../core/theme/typography.dart';
import '../modules/MainLayout/main_layout.dart';
import '../modules/MainLayout/main_layout_cubit.dart';
import '../utilities/constants/Strings.dart';
import '../utilities/constants/constants.dart';
import '../utilities/extensions.dart';
import 'Dialogs/settings_dialog.dart';
import 'DialogsHelper/dialog_widget.dart';

import '../utilities/constants/assets.dart';

class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.appName);
    final bool isExpanded =
        context.watch<MainLayoutCubit>().state.isExpanded ?? false;
    final MainLayoutCubit con = context.read<MainLayoutCubit>();

    return AnimatedContainer(
      width: isExpanded ? 200.w : 64.w,
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(8.r),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: ColorsPalette.of(context).backgroundColor,
          border: Border(
              left: isArabic(context)
                  ? BorderSide(
                      color: ColorsPalette.of(context).dividerColor,
                      width: 1,
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.h,
        children: [
          CircleAvatar(
            radius: (isExpanded ? 42 : 26).r,
            backgroundColor: ColorsPalette.of(context).dividerColor,
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: ColorsPalette.of(context).surfaceColor,
                radius: (isExpanded ? 40 : 24).r,
                child: SvgPicture.asset(
                  Assets.imagesProfile,
                  fit: BoxFit.cover,
                  width: isExpanded ? 48.w : 24.w,
                  height: isExpanded ? 48.h : 24.h,
                  colorFilter: ColorFilter.mode(
                    ColorsPalette.of(context).secondaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Text(
            isExpanded?(isArabic(context) ? 'علي مقلد' : 'Ali Mekld'):isArabic(context)?'ع.م':'AM',
            style: TextStyleHelper.of(context).bodyLarge16R.copyWith(
                  fontFamily: Constants.notoSansKoufyFontFamily,
                  fontSize: (isExpanded ? 16 : 12).sp,
                ),
          ),
          Divider(
            thickness: 1.h,
            color: ColorsPalette.of(context).dividerColor,
          ),
          ...menuList.mapIndexed(
            (i, e) => InkWell(
              borderRadius: Constants.kBorderRaduis8,
              onTap: () {
                con.onChangeSelected(i);
                context.goNamed(e.route);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: Constants.kBorderRaduis8,
                  color: con.isCurrent(i)
                      ? ColorsPalette.of(context).primaryColor
                      : null,
                ),
                height: 54.h,
                width: isExpanded ? 160.w : 54.w,
                child: Row(
                  mainAxisSize:
                      isExpanded ? MainAxisSize.max : MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: isExpanded
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      e.imgSvg,
                      height: 20.h,
                      width: 20.w,
                      colorFilter: ColorFilter.mode(
                        con.isCurrent(i)
                            ? Colors.white
                            : ColorsPalette.of(context).secondaryTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (isExpanded) ...[
                      16.w.widthBox,
                      Text(
                        e.title.tr,
                        style: TextStyleHelper.of(context)
                            .bodyMedium14R
                            .copyWith(
                              color: con.isCurrent(i) ? Colors.white70 : null,
                            ),
                      ).expand,
                    ]
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    const DialogHelper.customDialog(child: SettingsDialog())
                        .showDialog(context),
                icon: Icon(
                  Icons.settings,
                  size: 28.r,
                  color: ColorsPalette.of(context).primaryColor,
                ),
              ),
              24.h.heightBox,
              IconButton(
                onPressed: () => con.onToggleExpanded(!isExpanded),
                icon: Icon(
                  size: 28.r,

                  isExpanded
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_forward_ios_outlined,
                  color: ColorsPalette.of(context).primaryColor,
                ),
              ),
              16.h.heightBox,
            ],
          ).expand,
        ],
      ),
    );
  }
}
