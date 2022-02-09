import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';

class ExtendRequestModel {
  Invoice? invoice;
  Request? request;
  bool? isLoadingRequest;

  ExtendRequestModel() {
    isLoadingRequest = false;
  }

  get getInvoice => invoice;

  set setInvoice(invoice) => invoice = invoice;

  get getRequest => request;

  set setRequest(request) => request = request;

  get getIsLoadingRequest => isLoadingRequest;

  set setIsLoadingRequest(isLoadingRequest) =>
      this.isLoadingRequest = isLoadingRequest;
}
