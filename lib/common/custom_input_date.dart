import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

enum StatusTypeInput { VALID, INVALID, DISABLE }

class CustomOutLineInputDateTime extends StatefulWidget {
  final Size? deviceSize;
  final String? labelText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Color? backgroundColorLabel;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  StatusTypeInput? statusTypeInput;
  Function? validator;
  final bool? isDisable;
  final bool? isSecure;
  String icon;
  CustomOutLineInputDateTime(
      {this.statusTypeInput = StatusTypeInput.VALID,
      required this.controller,
      this.validator,
      this.backgroundColorLabel = CustomColor.white,
      this.textInputType = TextInputType.text,
      required this.isDisable,
      this.isSecure = false,
      this.nextNode,
      required this.icon,
      required this.focusNode,
      required this.deviceSize,
      required this.labelText});

  @override
  _CustomOutLineInputState createState() => _CustomOutLineInputState();
}

class _CustomOutLineInputState extends State<CustomOutLineInputDateTime> {
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.labelText!.isNotEmpty)
        Column(
          children: [
            CustomText(
                text: widget.labelText!,
                color: CustomColor.black,
                context: context,
                fontSize: 16),
            CustomSizedBox(context: context, height: 8),
          ],
        ),
      Container(
        height: widget.statusTypeInput != StatusTypeInput.INVALID
            ? widget.deviceSize!.height / 9.5
            : widget.deviceSize!.height / 7,
        width: widget.deviceSize!.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                  height: widget.deviceSize!.height / 15,
                  padding: const EdgeInsets.only(left: 16, top: 4, bottom: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: colorBorder, width: 1)),
                  child: Center(
                    child: TextFormField(
                      onTap: () async {
                        DateTime? date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        widget.controller?.text = date!.day.toString() +
                            "/" +
                            date.month.toString() +
                            "/" +
                            date.year.toString();
                      },
                      obscureText: widget.isSecure!,
                      validator:
                          widget.validator == null ? null : widget.validator!(),
                      maxLines: 1,
                      keyboardType: widget.textInputType,
                      style: TextStyle(color: colorLabel, fontSize: 16),
                      enabled: !widget.isDisable!,
                      textInputAction: widget.nextNode != null
                          ? TextInputAction.next
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
                        hintText: "dd/mm/yyyy",
                        suffixIcon: Image.asset(
                          widget.icon,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  )),
            ],
          ),
          if (widget.statusTypeInput == StatusTypeInput.INVALID)
            CustomSizedBox(
              context: context,
              height: 8,
            ),
          if (widget.statusTypeInput == StatusTypeInput.INVALID)
            CustomText(
              text: '* Required',
              color: Colors.red,
              context: context,
              textAlign: TextAlign.start,
              fontSize: 14,
            ),
          widget.statusTypeInput == StatusTypeInput.INVALID
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
    ]);
  }
}