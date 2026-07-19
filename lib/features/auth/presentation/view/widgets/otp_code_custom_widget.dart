import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpCodeCustomWidget extends StatefulWidget {
  const OtpCodeCustomWidget({
    super.key,
    required this.length,
    required this.onCompleted,
    this.boxSize,
    this.focusColor = Colors.blue,
    this.unfocusColor = Colors.grey,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final double? boxSize;
  final Color focusColor;
  final Color unfocusColor;

  @override
  State<OtpCodeCustomWidget> createState() => _OtpCodeCustomWidgetState();
}

class _OtpCodeCustomWidgetState extends State<OtpCodeCustomWidget> {
  late List<TextEditingController> codes;
  late List<FocusNode> nodes;

  @override
  void initState() {
    super.initState();
    codes = List.generate(widget.length, (_) => TextEditingController());
    nodes = List.generate(widget.length, (index) {
      final node = FocusNode();
      node.onKeyEvent = (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            codes[index].text.isEmpty) {
          _goToPreviousField(index);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
      return node;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) nodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final code in codes) {
      code.dispose();
    }
    for (final node in nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 10.0;
        final calculatedSize =
            widget.boxSize ??
            ((constraints.maxWidth - spacing * (widget.length - 1)) /
                    widget.length)
                .clamp(40.0, 60.0);

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.spaceAround,
          runAlignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(
            widget.length,
            (index) => _textField(index, calculatedSize),
          ),
        );
      },
    );
  }

  Widget _textField(int index, double size) {
    final controller = codes[index];
    final node = nodes[index];

    return SizedBox(
      width: size,
      height: size,
      child: TextFormField(
        controller: controller,
        focusNode: node,
        showCursor: false,
        stylusHandwritingEnabled: false,
        enableIMEPersonalizedLearning: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        cursorColor: Colors.transparent,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: widget.length, // allow full paste to land here temporarily
        enableSuggestions: false,
        onChanged: (value) => _handleChange(index, value),
        onTap: () {
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        },
        decoration: InputDecoration(
          counterText: "",
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.focusColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.unfocusColor, width: 2),
          ),
        ),
      ),
    );
  }

  void _handleChange(int index, String value) {
    if (value.length > 1) {
      _distributePastedCode(value);
      return;
    }

    if (value.isNotEmpty) {
      _goToNextField(index);
    }
    _checkCompletion();
  }

  void _distributePastedCode(String pasted) {
    final digits = pasted.replaceAll(RegExp(r'\D'), '');
    for (var i = 0; i < widget.length; i++) {
      codes[i].text = i < digits.length ? digits[i] : '';
    }
    final lastFilledIndex = (digits.length - 1).clamp(0, widget.length - 1);
    nodes[lastFilledIndex].requestFocus();
    _checkCompletion();
  }

  void _goToNextField(int index) {
    if (index < nodes.length - 1) {
      nodes[index + 1].requestFocus();
    } else {
      nodes[index].unfocus();
    }
  }

  void _goToPreviousField(int index) {
    if (index > 0) {
      nodes[index - 1].requestFocus();
      codes[index - 1].clear();
    }
  }

  void _checkCompletion() {
    final code = codes.map((c) => c.text).join();
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }
}
