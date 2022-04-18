import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/storage_entity.dart';

class StorageChoiceWidget extends StatefulWidget {
  final StorageEntity storageEntity;
  final String? currentIdStorage;
  final Function onChoice;
  const StorageChoiceWidget(
      {Key? key,
      required this.storageEntity,
      required this.currentIdStorage,
      required this.onChoice})
      : super(key: key);

  @override
  State<StorageChoiceWidget> createState() => _StorageChoiceWidgetState();
}

class _StorageChoiceWidgetState extends State<StorageChoiceWidget> {
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: const Color(0x00000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Column(
        children: [
          Image.network(widget.storageEntity.imageUrl),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
            text: widget.storageEntity.name,
            color: CustomColor.black,
            context: context,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
            text: widget.storageEntity.address,
            color: CustomColor.black,
            context: context,
            fontSize: 16,
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          Row(
            children: [
              CustomText(
                text: 'Phí vận chuyển: ',
                color: CustomColor.black,
                context: context,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: '${oCcy.format(widget.storageEntity.deliveryFee)}  đ',
                color: CustomColor.blue,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ],
          ),
          Radio<String>(
            value: widget.storageEntity.id,
            groupValue: widget.currentIdStorage,
            onChanged: (String? value) {
              widget.onChoice(value);
            },
          ),
        ],
      ),
    );
  }
}
