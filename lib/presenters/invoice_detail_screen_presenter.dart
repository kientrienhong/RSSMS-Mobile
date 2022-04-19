import 'dart:convert';
import 'dart:developer';

import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/invoice_detail_screen.dart';
import 'package:rssms/views/invoice_detail_screen_view.dart';

class InvoiceDetailScreenPresenter {
  late InvoiceDetailScreenModel model;
  late InvoiceDetailScreenView view;

  InvoiceDetailScreenPresenter() {
    model = InvoiceDetailScreenModel();
  }

  Invoice formatItemTabInvoice(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith();

    invoiceResult.orderDetails.forEach((element) {
      if (element.productType == typeProduct.accessory.index ||
          element.productType == typeProduct.services.index) {
        element.serviceImageUrl = element.listAdditionService![0].imageUrl;
        element.price = element.listAdditionService![0].price;
        element.amount = element.listAdditionService![0].quantity!;
      } else {
        element.listAdditionService = element.listAdditionService!
            .where((element) =>
                element.type == typeProduct.accessory.index ||
                element.type == typeProduct.services.index)
            .toList();
      }
    });

    return invoiceResult;
  }

  void loadingDetailInvoice(String id, String idToken) async {
    try {
      final response = await model.loadingDetailInvoice(id, idToken);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        Invoice invoice = Invoice.fromMap(decodedResponse);
        model.orginalInvoice = invoice;
        Invoice updatedInvoice = formatUIInvoice(invoice);
        view.updateView(formatItemTabInvoice(invoice), updatedInvoice);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      view.updateLoading();
    }
  }

  Invoice formatUIInvoice(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith(orderDetails: []);

    invoice.orderDetails.forEach((element) {
      element.listAdditionService!.forEach((ele) {
        int index = invoiceResult.orderDetails
            .indexWhere((ele1) => ele1.productId == ele.id);
        if (index == -1) {
          invoiceResult.orderDetails.add(OrderDetail(
              id: '0',
              productId: ele.id,
              productName: ele.name,
              price: ele.price,
              status: -1,
              amount: ele.quantity!,
              serviceImageUrl: ele.imageUrl,
              productType: ele.type,
              note: '',
              images: []));
        } else {
          invoiceResult.orderDetails[index].amount += ele.quantity!;
        }
      });
    });
    return invoiceResult;
  }
}
