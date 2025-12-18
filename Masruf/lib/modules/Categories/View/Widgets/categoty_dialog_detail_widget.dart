import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Language/app_localization.dart';
import '../../../../core/theme/color_pallet.dart';
import '../../../../core/theme/typography.dart';
import '../../../../models/drop_down_model.dart';
import '../../Model/DataSource/categories_local_data_source.dart';
import '../../../../utilities/constants/Strings.dart';
import '../../../../utilities/extensions.dart';
import '../../../../widgets/DialogsHelper/dialog_widget.dart';
import '../../../../widgets/custom_text_field_widget.dart';
import '../../../../widgets/cutom_button_widget.dart';

class CategoryDialogDetailWidget extends StatefulWidget {
  final int? id;
  final Function(DropdownModel? model)? onInsertUpdateCategory;
  const CategoryDialogDetailWidget({
    super.key,
    this.id,
    this.onInsertUpdateCategory,
  });

  @override
  State<CategoryDialogDetailWidget> createState() =>
      _CategoryDialogDetailWidgetState();
}

class _CategoryDialogDetailWidgetState
    extends State<CategoryDialogDetailWidget> {
  late TextEditingController categoryNumberController,
      categoryNameController,
      categoryENameController;

  @override
  void initState() {
    super.initState();
    categoryNumberController = TextEditingController();
    categoryNameController = TextEditingController();
    categoryENameController = TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await getCategoryById());
  }

  Future getCategoryById() async {
    if (widget.id == null) return;
    final result =
        await CategoriesLocalDataSource().getCategoryByID(widget.id!);
    result.fold((l) {
      DialogHelper.error(message: l.toString()).showDialog(context);
    }, (r) {
      model = r;
      setCategoryData(r);
    });
    setState(() {});
  }

  DropdownModel? model;
  void setCategoryData(DropdownModel m) {
    categoryNumberController.text = m.id?.toString() ?? '';
    categoryNameController.text = m.name ?? '';
    categoryENameController.text = m.eName ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    categoryNumberController.dispose();
    categoryNameController.dispose();
    categoryENameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)?.translate(Strings.expenseDetails);
    return SizedBox(
      height: 420.h,
      width: 400.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.categoryData.tr,
                style: TextStyleHelper.of(context).headlineSmall24R,
                textAlign: TextAlign.start,
              ),
              IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.cancel,
                    color: ColorsPalette.of(context)
                        .errorColor
                        .withValues(alpha: 0.8),
                    size: 32.r,
                  ))
            ],
          ),
          Divider(
            color: ColorsPalette.of(context).dividerColor,
          ).addPaddingAll(padding: 4.r),
          16.h.heightBox,
          SingleChildScrollView(
            child: Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                CustomTextFieldWidget(
                  enabled: false,
                  controller: categoryNumberController,
                  lableText: Strings.id.tr,
                  width: 400.w,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: categoryNameController,
                  lableText: Strings.expenseName.tr,
                ),
                CustomTextFieldWidget(
                  width: 400.w,
                  controller: categoryENameController,
                  lableText: Strings.eName.tr,
                ),
              ],
            ),
          ).expand,
          40.h.heightBox,
          CustomButtonWidget.primary(
            context: context,
            buttonTitle: Strings.confirm.tr,
            onTap: () {
              model ??= const DropdownModel();
              model = model?.copyWith(
                id: int.tryParse(categoryNumberController.text),
                name: categoryNameController.text,
                eName: categoryENameController.text,
              );
              if (widget.onInsertUpdateCategory != null) {
                widget.onInsertUpdateCategory!(model!);
              }
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
