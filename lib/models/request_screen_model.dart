import 'dart:async';

import 'package:rssms/models/entity/request.dart';

class RequestScreenModel {
  List<Request>? listRequest;
  List<Request>? listRequestFull;

  bool? isLoadingRequest;
  bool? hasMore;

  Map<String, dynamic>? metadata;
  Stream<List<Request>>? stream;
  StreamController<List<Request>>? _controller;
  List<Request>? _data;
  int? page;
  int? totalPage;

  RequestScreenModel() {
    listRequest = List<Request>.empty(growable: true);
    listRequestFull = List<Request>.empty(growable: true);
    isLoadingRequest = false;

    page = 1;
    _data = [];
    _controller = StreamController<List<Request>>.broadcast();
    stream = _controller!.stream.map((event) {
      return event;
    });
    hasMore = true;
  }
  get getListRequest => listRequest;

  set setListRequest(listRequest) => listRequest = listRequest;

  get getListRequestFull => listRequestFull;

  set setListRequestFull(listRequestFull) =>
      listRequestFull = listRequestFull;

  get getIsLoadingRequest => isLoadingRequest;

  set setIsLoadingRequest(isLoadingRequest) =>
      isLoadingRequest = isLoadingRequest;

  get getHasMore => hasMore;

  set setHasMore(hasMore) => hasMore = hasMore;

  get getMetadata => metadata;

  set setMetadata(metadata) => metadata = metadata;

  get getStream => stream;

  set setStream(stream) => stream = stream;

  get controller => _controller;

  set controller(value) => _controller = value;

  get data => _data;

  set data(value) => _data = value;

  get getPage => page;

  set setPage(page) => page = page;

  get getTotalPage => totalPage;

  set setTotalPage(totalPage) => totalPage = totalPage;
}
