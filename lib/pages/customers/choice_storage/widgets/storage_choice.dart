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
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: const Color(0x00000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Row(
        children: [
          SizedBox(
            child: Image.network(
              widget.storageEntity.imageUrl,
              fit: BoxFit.cover,
            ),
            height: deviceSize.height / 11,
            width: deviceSize.width / 4,
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: CustomText(
                    text: widget.storageEntity.name,
                    color: CustomColor.black,
                    context: context,
                    fontSize: 15,
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  height: 7,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Địa chỉ: ',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 13,
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                    ),
                    Flexible(
                      child: SizedBox(
                        child: CustomText(
                          text: widget.storageEntity.address,
                          color: CustomColor.black,
                          context: context,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 7,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'Phí vận chuyển: ',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 13,
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text:
                          '${oCcy.format(widget.storageEntity.deliveryFee)}  đ',
                      color: CustomColor.blue,
                      context: context,
                      maxLines: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 7,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'Khoảng cách: ',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 13,
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: widget.storageEntity.deliveryDistance,
                      color: CustomColor.blue,
                      context: context,
                      maxLines: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
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
