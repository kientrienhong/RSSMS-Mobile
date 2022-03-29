import '/common/custom_color.dart';
import 'package:flutter/material.dart';

enum StatusTypeInput { VALID, INVALID, DISABLE }

class CustomOutLineInputWithHint extends StatefulWidget {
  final Size? deviceSize;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Color? backgroundColorLabel;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  StatusTypeInput? statusTypeInput;
  Function(String?)? validator;
  final bool? isDisable;
  final bool? isSecure;
  final int? maxLine;
  String? hintText;
  CustomOutLineInputWithHint(
      {Key? key,
      this.statusTypeInput = StatusTypeInput.VALID,
      required this.controller,
      this.validator,
      this.backgroundColorLabel = CustomColor.white,
      this.textInputType = TextInputType.text,
      required this.isDisable,
      this.isSecure = false,
      this.nextNode,
      this.maxLine = 1,
      required this.focusNode,
      required this.deviceSize,
      this.hintText})
      : super(key: key);

  @override
  _CustomOutLineInputState createState() => _CustomOutLineInputState();
}

class _CustomOutLineInputState extends State<CustomOutLineInputWithHint> {
  late Color colorBorder;
  late Color colorLabel;
  @override
  void initState() {
    super.initState();

    switch (widget.statusTypeInput) {
      case StatusTypeInput.VALID:
        {
          colorLabel = Colors.black;
          colorBorder = CustomColor.black[3]!;
          break;
        }

      case StatusTypeInput.DISABLE:
        {
          colorLabel = CustomColor.black[3]!;
          colorBorder = CustomColor.black[3]!;
          break;
        }

      default:
        {
          colorLabel = Colors.red;
          colorBorder = Colors.red;
        }
    }
    widget.focusNode!.addListener(_onFocusChange);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void _onFocusChange() {
    if (widget.focusNode!.hasFocus) {
      setStateIfMounted(() {
        colorBorder = CustomColor.blue;
        colorLabel = CustomColor.blue;
      });
    } else {
      if (widget.controller == null) {
        return;
      }
      if (widget.controller!.text.isEmpty) {
        setStateIfMounted(() {
          colorBorder = Colors.red;
          colorLabel = Colors.red;
          widget.statusTypeInput = StatusTypeInput.INVALID;
        });

        return;
      }
      setStateIfMounted(() {
        colorBorder = CustomColor.black[3]!;
        colorLabel = Colors.black;
        widget.statusTypeInput = StatusTypeInput.VALID;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: widget.isSecure!,
              validator: widget.validator == null
                  ? null
                  : (val) {
                      print(val);
                      return widget.validator!(widget.controller!.text);
                    },
              maxLines: widget.maxLine,
              keyboardType: widget.textInputType,
              style: TextStyle(color: colorLabel, fontSize: 16),
              enabled: !widget.isDisable!,
              textInputAction: widget.nextNode != null
                  ? TextInputAction.next
                  : widget.maxLine! > 1
                      ? TextInputAction.newline
                      : TextInputAction.done,
              onFieldSubmitted: (term) {
                widget.focusNode!.unfocus();
                if (widget.nextNode != null) {
                  FocusScope.of(context).requestFocus(widget.nextNode);
                }
              },
              controller: widget.controller,
              focusNode: widget.focusNode,
              cursorColor: CustomColor.blue,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                isCollapsed: true,
                hintText: widget.hintText,
                hintStyle: const TextStyle(height: 1),
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
                  borderSide: BorderSide(color: CustomColor.red, width: 1),
                ),
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
