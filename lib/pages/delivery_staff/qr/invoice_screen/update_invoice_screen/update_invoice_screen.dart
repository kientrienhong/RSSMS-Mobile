import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/update_image_invoice.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/pages/log_in/widget/button_icon.dart';

class UpdateInvoiceScreen extends StatefulWidget {
  Map<String, dynamic>? invoice;
  UpdateInvoiceScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  _UpdateInvoiceScreenState createState() => _UpdateInvoiceScreenState();
}

enum STATUS_INVOICE { dadat, luukho, yeucautra, datra }

class _UpdateInvoiceScreenState extends State<UpdateInvoiceScreen> {
  final _focusNodeFullname = FocusNode();
  final _focusNodePhone = FocusNode();
  final _controllerFullname = TextEditingController();
  final _controllerPhone = TextEditingController();

  String get _fullname => _controllerFullname.text;
  String get _phone => _controllerPhone.text;
  STATUS_INVOICE? status;
  File? image;
  List<AddedImage>? listImage = [];
  bool? isPaid = false;
  @override
  void dispose() {
    super.dispose();
    _focusNodeFullname.dispose();
    _focusNodePhone.dispose();

    _controllerFullname.dispose();
    _controllerPhone.dispose();
  }

  _buildGridView({
    required List<AddedImage> path,
    required Size deviceSize,
  }) {
    return SizedBox(
      height:
          path.length >= 2 ? deviceSize.height / 1.8 : deviceSize.height / 4,
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              mainAxisSpacing: 7),
          itemCount: path.length == 4 ? path.length : path.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == path.length) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: DottedBorder(
                    color: CustomColor.black,
                    strokeWidth: 1,
                    dashPattern: const [8, 4],
                    child: Center(
                      child: ButtonIcon(
                          height: path.length >= 2
                              ? deviceSize.height / 2.6
                              : deviceSize.height / 4,
                          width: 50,
                          url: "assets/images/plus.png",
                          text: "",
                          onPressFunction: () => showDialog(
                              context: context,
                              builder: (ctx) {
                                return UpdateImageInvoice(
                                  isDisable: false,
                                );
                              }),
                          isLoading: false,
                          textColor: Colors.white,
                          buttonColor: Colors.white,
                          borderRadius: 2),
                    )),
              );
            }
            return Stack(children: [
              Container(
                width: deviceSize.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 14,
                          color: Color(0x000000).withOpacity(0.06),
                          offset: const Offset(0, 6)),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        path[index].image!,
                        height: deviceSize.height / 6.5,
                        width: deviceSize.width,
                      ),
                    ),
                    CustomText(
                        text: path[index].name.toString(),
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      listImage!.removeAt(index);
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.red;
                    }),
                  ),
                ),
              )
            ]);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    listImage = Provider.of<AddedImage>(context).listImage;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/arrowLeft.png'),
                    ),
                  ),
                  CustomText(
                      text: "Cập nhật đơn hàng",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  CustomSizedBox(
                    context: context,
                    height: 0,
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: "Thông tin khách hàng",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomOutLineInputWithHint(
                  controller: _controllerFullname,
                  isDisable: false,
                  hintText: "Họ và Tên",
                  focusNode: _focusNodeFullname,
                  deviceSize: deviceSize),
              CustomOutLineInputWithHint(
                  controller: _controllerPhone,
                  isDisable: false,
                  hintText: "Phone",
                  focusNode: _focusNodePhone,
                  deviceSize: deviceSize),
              CustomText(
                text: "Hình ảnh",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Consumer<AddedImage>(
                builder: (context, image, child) {
                  return _buildGridView(
                      deviceSize: deviceSize, path: listImage!);
                },
              ),
              CustomText(
                text: "Tình trạng đơn hàng",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      status = STATUS_INVOICE.dadat;
                    });
                  },
                  text: "Đã đặt",
                  color: Colors.black,
                  state: status,
                  value: STATUS_INVOICE.dadat),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      status = STATUS_INVOICE.luukho;
                    });
                  },
                  text: "Đang lưu kho",
                  color: CustomColor.black,
                  state: status,
                  value: STATUS_INVOICE.luukho),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      status = STATUS_INVOICE.yeucautra;
                    });
                  },
                  text: "Yêu cầu trả",
                  color: CustomColor.black,
                  state: status,
                  value: STATUS_INVOICE.yeucautra),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      status = STATUS_INVOICE.datra;
                    });
                  },
                  text: "Đã trả",
                  color: CustomColor.black,
                  state: status,
                  value: STATUS_INVOICE.datra),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Đã thanh toán",
                    color: CustomColor.black,
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(CustomColor.blue),
                      value: isPaid,
                      onChanged: (value) {
                        setState(() {
                          isPaid = value;
                        });
                      })
                ],
              ),
              Center(
                child: CustomButton(
                    height: 24,
                    isLoading: false,
                    text: 'Cập nhật đơn',
                    textColor: CustomColor.white,
                    onPressFunction: null,
                    width: deviceSize.width / 2.5,
                    buttonColor: CustomColor.blue,
                    borderRadius: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
