import 'package:rssms/models/entity/request.dart';

class RequestScreenModel{
  List<Request>? listRequest;
  bool? isLoadingRequest;

RequestScreenModel(){
  listRequest = [];
  isLoadingRequest = false;
}


  get getListRequest => listRequest;

 set setListRequest( listRequest) => listRequest = listRequest;

  get getIsLoadingRequest => isLoadingRequest;

 set setIsLoadingRequest( isLoadingRequest) => isLoadingRequest = isLoadingRequest;
}