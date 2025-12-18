import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/Language/app_localization.dart';
import '../../core/Language/language_provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/typography.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/extensions.dart';
import '../custom_drop_down_widget.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.save);
    return SizedBox(
      height: context.isTabletOrMobile ? 348.h : 400.h,
      width: context.isTabletOrMobile ? 220.w : 280.w,
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, lang, theme, child) => Column(
          crossAxisAlignment: context.isTabletOrMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              Strings.settings.tr,
              style: TextStyleHelper.of(context).titleLarge22R,
            ),
            const Divider().addPaddingVertical(padding: 8.h),
            Text(
              Strings.language.tr,
              style: TextStyleHelper.of(context)
                  .bodyLarge16R
                  .copyWith(fontSize: 20),
            ),
            8.h.heightBox,
            CustomDropdownWidget(
                items: Languages.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.tr,
                          style: TextStyleHelper.of(context).bodyLarge16R,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) async {
                  await lang.changeLanguage(language: v);
                },
                selectedItem:
                    Languages.values.firstWhereOrNull((e) => e == lang.state)),
            const Divider().addPaddingVertical(padding: 8.h),
            Text(
              Strings.theme.tr,
              style: TextStyleHelper.of(context)
                  .bodyLarge16R
                  .copyWith(fontSize: 20),
            ),
            8.h.heightBox,
            CustomDropdownWidget(
                items: SystemBrightness.values
                    .map(
                      (e) => DropdownMenuItem<SystemBrightness>(
                        value: e,
                        child: Text(
                          e.name.tr,
                          style: TextStyleHelper.of(context).bodyLarge16R,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  theme.changeTheme(v ?? SystemBrightness.dark);
                },
                selectedItem: SystemBrightness.values
                    .firstWhereOrNull((e) => e == theme.state)),
          ],
        ),
      ),
    );
  }
}
