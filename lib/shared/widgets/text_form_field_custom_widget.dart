import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class TextFormFieldWithLabelCustomWidget extends StatefulWidget {
  const TextFormFieldWithLabelCustomWidget({
    required this.controller,
    this.validator,
    this.enabled,
    this.hidden,
    this.isTextBox,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    this.onChanged,
    this.onSubmit,
    this.realtimeChange,
    this.errorWatcher,
    super.key,
  });

  final bool? realtimeChange;
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(bool?)? errorWatcher;
  final void Function(String value)? onChanged;
  final void Function()? onSubmit;
  final String? labelText;
  final bool? isTextBox;
  final bool? enabled;
  final bool? hidden;

  @override
  State<TextFormFieldWithLabelCustomWidget> createState() =>
      _TextFormFieldWithLabelCustomWidgetState();
}

class _TextFormFieldWithLabelCustomWidgetState
    extends State<TextFormFieldWithLabelCustomWidget> {
  late final FocusNode _focusNode;
  late final GlobalKey<FormFieldState<String>> _fieldKey;
  late bool _obscureText;
  bool? _isError;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _fieldKey = GlobalKey<FormFieldState<String>>();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden == true) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        TextFormField(
          key: widget.realtimeChange == true ? _fieldKey : null,
          focusNode: _focusNode,
          autofocus: false,
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          maxLines: _obscureText ? 1 : (widget.isTextBox == true ? 5 : 1),
          onEditingComplete: widget.onSubmit,
          style: AppTextStyles.bodyMedium,
          validator: (val) {
            final errorMsg = widget.validator?.call(val);
            setState(() => _isError = errorMsg == null);
            widget.errorWatcher?.call(_isError);
            return errorMsg;
          },
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.realtimeChange == true) {
              _fieldKey.currentState?.validate();
            }
          },
          errorBuilder: (context, errorText) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                SvgPicture.asset(
                  _isError == true ? AppIcons.check1 : AppIcons.warningCircle,
                  width: 15,
                  height: 15,
                  colorFilter: ColorFilter.mode(
                    AppColors.error,
                    BlendMode.srcIn,
                  ),
                ),
                Expanded(
                  child: Text(
                    errorText,
                    softWrap: true,
                    style: AppTextStyles.label.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            );
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
            suffixIcon: _getIcon(),
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: _border(
              color: _isError == true ? AppColors.success : AppColors.divider,
            ),
            focusedBorder: _border(
              color: _isError == true ? AppColors.success : AppColors.divider,
            ),
            errorBorder: _border(color: AppColors.error),
            focusedErrorBorder: _border(color: AppColors.error),
            disabledBorder: _border(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  Widget? _getIcon() {
    List<Widget> icons = [];
    if (widget.isPassword) {
      icons.add(
        IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.divider,
            size: 24,
          ),
          onPressed: () => setState(() {
            _obscureText = !_obscureText;
          }),
        ),
      );
    }
    if (_isError != null) {
      icons.add(
        SvgPicture.asset(
          _isError == true ? AppIcons.check1 : AppIcons.warningCircle,
          width: 25,
          height: 25,
          colorFilter: ColorFilter.mode(
            _isError == true ? AppColors.success : AppColors.error,
            BlendMode.srcIn,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(mainAxisSize: MainAxisSize.min, spacing: 4, children: icons),
    );
  }
}
