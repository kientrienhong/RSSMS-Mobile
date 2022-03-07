import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/product.dart';

class QuantityWidget extends StatefulWidget {
  final Product? product;
  final double? width;
  final VoidCallback? addQuantity;
  final VoidCallback? minusQuantity;
  final MainAxisAlignment? mainAxisAlignment;

  const QuantityWidget(
      {Key? key,
      this.product,
      this.width,
      this.minusQuantity,
      this.addQuantity,
      this.mainAxisAlignment})
      : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        TextEditingController(text: widget.product!.quantity.toString());
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment!,
      children: [
        GestureDetector(
          onTap: widget.minusQuantity,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColor.black[3]!),
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child: CustomText(
                  text: '-',
                  color: CustomColor.black[3]!,
                  context: context,
                  fontSize: 32),
            ),
          ),
          // child: SizedBox(
          //     height: 40,
          //     child: Image.asset(
          //       'assets/images/minusButton.png',
          //       fit: BoxFit.cover,
          //     )),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        SizedBox(
          width: widget.width,
          height: 40,
          child: TextFormField(
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: CustomColor.black[3]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: CustomColor.black[3]!)),
            ),
            controller: _controller,
          ),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        GestureDetector(
          onTap: widget.addQuantity,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: CustomColor.blue),
            child: Center(
              child: CustomText(
                  text: '+',
                  color: CustomColor.white,
                  context: context,
                  fontSize: 32),
            ),
          ),
        ),
      ],
    );
  }
}
