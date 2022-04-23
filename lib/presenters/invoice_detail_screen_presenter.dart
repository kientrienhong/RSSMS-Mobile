import 'dart:convert';
import 'dart:developer';

import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/request.dart';
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
    for (var element in invoiceResult.orderDetails) {
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
    }

    return invoiceResult;
  }

  bool checkRequestReturnItem(List<Request> invoice) {
    for (var element in invoice) {
      if (element.type == 4) {
        if ((element.status == 1 ||
            element.status == 2 ||
            element.status == 4)) {
          model.request = element;
          return true;
        }
      }
    }
    return false;
  }

  Request getRequestCreated(List<Request> invoice) {
    for (var element in invoice) {
      if (element.type == REQUEST_TYPE.createOrder.index) {
        return element;
      }
    }
    return Request.empty();
  }

  void loadingDetailInvoice(String id, String idToken) async {
    try {
      final response = await model.loadingDetailInvoice(id, idToken);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        Invoice invoice = Invoice.fromMap(decodedResponse);
        model.orginalInvoice = invoice;
        if (decodedResponse['importCode'] != null) {
          model.import = Import.fromMap(decodedResponse);
        }
        if (decodedResponse['exportCode'] != null) {
          model.export = Export.fromMap(decodedResponse);
        } else {
          List<Request>? listReqTemp = decodedResponse['requests']
              .map<Request>((e) => Request.fromMap(e))
              .toList();
          model.isRequestReturn = checkRequestReturnItem(listReqTemp!);
          Request createRequest = getRequestCreated(listReqTemp);
          model.orginalInvoice.advanceMoney = createRequest.advanceMoney;
          model.orginalInvoice.deliveryFee = createRequest.deliveryFee;
        }

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
    for (var element in invoice.orderDetails) {
      for (var ele in element.listAdditionService!) {
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
      }
    }
    return invoiceResult;
  }
}
