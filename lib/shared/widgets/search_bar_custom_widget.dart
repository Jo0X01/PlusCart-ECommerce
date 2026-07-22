import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class SearchBarCustomWidget extends StatelessWidget {
  const SearchBarCustomWidget({
    super.key,
    this.controller,
    this.enabled,
    this.onChange,
    this.enableFilter,
    this.enableVoice,
    this.onFilter,
    this.onVoice,
    this.hintText,
    this.margin,
  });
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final bool? enabled;
  final void Function(String)? onChange;
  final bool? enableFilter;
  final bool? enableVoice;
  final void Function()? onFilter;
  final void Function()? onVoice;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      margin: margin,
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 6,
            child: TextFormFieldWithLabelCustomWidget(
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              hintText: "Search ...",
              validator: Validator.validateName,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SvgPicture.asset(
                  AppIcons.search,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.textHint,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: SvgPicture.asset(
                AppIcons.mic,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          if (enableFilter == true)
            Expanded(
              child: GestureDetector(
                onTap: onFilter,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    AppIcons.filter,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.surface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
