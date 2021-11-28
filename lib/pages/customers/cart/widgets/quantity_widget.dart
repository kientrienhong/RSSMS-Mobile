import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class QuantityWidget extends StatefulWidget {
  final Map<String, dynamic>? product;
  final double? width;
  const QuantityWidget({Key? key, this.product, this.width}) : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.product!['quantity'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/minusButton.png'),
        SizedBox(
          width: widget.width,
          height: 24,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
        Image.asset('assets/images/addButton.png'),
      ],
    );
  }
}
