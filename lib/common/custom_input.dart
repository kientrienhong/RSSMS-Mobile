import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

enum StatusTypeInput { valid, invalid, disable }

class CustomOutLineInput extends StatefulWidget {
  final Size deviceSize;
  final String? labelText;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final Color? backgroundColorLabel;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function? validator;
  final bool isDisable;
  final bool? isSecure;
  final int? maxLine;
  const CustomOutLineInput(
      {Key? key,
      required this.controller,
      this.validator,
      this.backgroundColorLabel = CustomColor.white,
      this.textInputType = TextInputType.text,
      required this.isDisable,
      this.isSecure = false,
      this.nextNode,
      required this.focusNode,
      required this.deviceSize,
      this.maxLine = 1,
      required this.labelText})
      : super(key: key);

  @override
  _CustomOutLineInputState createState() => _CustomOutLineInputState();
}

class _CustomOutLineInputState extends State<CustomOutLineInput> {
  late Color colorBorder;
  late Color colorLabel;
  late StatusTypeInput statusTypeInput;

  @override
  void initState() {
    super.initState();

    statusTypeInput = StatusTypeInput.valid;
    colorLabel = Colors.black;
    colorBorder = CustomColor.black[3]!;
    widget.focusNode.addListener(_onFocusChange);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus) {
      setStateIfMounted(() {
        colorBorder = CustomColor.blue;
        colorLabel = CustomColor.blue;
      });
    } else {
      if (widget.controller.text.isEmpty) {
        setStateIfMounted(() {
          colorBorder = Colors.red;
          colorLabel = Colors.red;
          statusTypeInput = StatusTypeInput.invalid;
        });

        return;
      }
      setStateIfMounted(() {
        colorBorder = CustomColor.black[3]!;
        colorLabel = Colors.black;
        statusTypeInput = StatusTypeInput.valid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomText(
            text: widget.labelText!,
            color: CustomColor.black,
            fontWeight: FontWeight.bold,
            context: context,
            fontSize: 16),
        CustomSizedBox(context: context, height: 8),
        SizedBox(
          width: widget.deviceSize.width,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    TextFormField(
                      obscureText: widget.isSecure!,
                      validator: widget.validator == null
                          ? null
                          : (val) {
                              return widget.validator!(widget.controller.text);
                            },
                      maxLines: widget.maxLine,
                      keyboardType: widget.textInputType,
                      style: TextStyle(color: colorLabel, fontSize: 16),
                      enabled: !widget.isDisable,
                      textInputAction: widget.nextNode != null
                          ? TextInputAction.next
                          : TextInputAction.done,
                      onFieldSubmitted: (term) {
                        widget.focusNode.unfocus();
                        if (widget.nextNode != null) {
                          FocusScope.of(context).requestFocus(widget.nextNode);
                        }
                      },
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      cursorColor: CustomColor.blue,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        isCollapsed: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorder, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorder, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorder, width: 1),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColor.red, width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorBorder, width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
                if (statusTypeInput == StatusTypeInput.invalid)
                  CustomSizedBox(
                    context: context,
                    height: 8,
                  ),
                if (statusTypeInput == StatusTypeInput.invalid)
                  CustomText(
                    text: '* Vui l??ng nh???p',
                    color: Colors.red,
                    context: context,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                  ),
                statusTypeInput == StatusTypeInput.invalid
                    ? CustomSizedBox(
                        context: context,
                        height: 8,
                      )
                    : CustomSizedBox(
                        context: context,
                        height: 4,
                      ),
              ]),
        ),
      ]),
    );
  }
}
