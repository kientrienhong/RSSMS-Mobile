import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';

class QuantityWidgetCustom extends StatefulWidget {
  final int? quantity;
  final double? width;
  final VoidCallback? addQuantity;
  final VoidCallback? minusQuantity;
  final MainAxisAlignment? mainAxisAlignment;

  const QuantityWidgetCustom(
      {Key? key,
      this.quantity,
      this.width,
      this.minusQuantity,
      this.addQuantity,
      this.mainAxisAlignment})
      : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidgetCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        TextEditingController(text: widget.quantity.toString());
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment!,
      children: [
        GestureDetector(
          onTap: widget.minusQuantity,
          child: SizedBox(
              height: 20,
              child: Image.asset(
                'assets/images/minusButton.png',
                fit: BoxFit.cover,
              )),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        SizedBox(
          width: widget.width,
          height: 24,
          child: TextFormField(
            readOnly: true,
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
          child: SizedBox(
              height: 20,
              child: Image.asset('assets/images/addButton.png',
                  fit: BoxFit.cover)),
        ),
      ],
    );
  }
}
