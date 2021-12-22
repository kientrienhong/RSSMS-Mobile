import 'package:flutter/cupertino.dart';

class InvoiceImageWidget extends StatelessWidget {
  Map<String, dynamic> image;

  InvoiceImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(image["url"]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
