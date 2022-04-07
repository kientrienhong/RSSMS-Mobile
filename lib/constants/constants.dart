import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';

enum REQUEST_TYPE {
  cancelSchedule,
  createOrder,
  extendOrder,
  cancelRequestCreateOrder,
  returnOrder
}

enum ADDITION_FEE_TYPE {
  takingAdditionFee,
  returningAdditionFee,
  compensationFee
}

const List<Map<String, String>> TAB_INVOICE_DETAIL = [
  {"name": "Hóa đơn"},
  {"name": "Đồ đạc"}
];

const DOOR_TO_DOOR_TYPE_ORDER = 1;
const SELF_STORAGE_TYPE_ORDER = 0;

const List<Map<String, String>> LIST_CUSTOMER_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/addIcon.png", 'label': 'Cart'},
  {'url': "assets/images/notification.png", 'label': 'Notification'},
];

const List<Map<String, String>> LIST_DELIVERY_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/deliveryNav.png", 'label': 'Schedule'},
  {'url': "assets/images/qrCode.png", 'label': 'QR'},
  {'url': "assets/images/notification.png", 'label': 'Notification'},
];

const List<Map<String, String>> LIST_OFFICE_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/qrCode.png", 'label': 'QR'},
];

const DOOR_TO_DOOR_TAB = 0;
const SELF_STORAGE_TAB = 1;

const REQUEST_TYPE_CANCEL_SCHEDULE = 0;
const REQUEST_TYPE_CREATE_ORDER = 1;
const REQUEST_TYPE_EXTEND_ORDER = 2;
const REQUEST_TYPE_CANCEL_ORDER = 3;
const REQUEST_TYPE_RETURN_ORDER = 4;

const TYPE_PRODUCT = {
  "SELF_STORAGE": 0,
  'ACCESSORY': 1,
  'HANDY': 2,
  'UNWEILDY': 4,
  'SERVICES': 3,
};

// STATUS_INVOICE
const BOOKED = 1;
const ASSIGNED = 2;
const DELIVERIED = 3;
const STORED = 4;
const EXPIRED = 5;
const DONE = 6;
const DELIVERIED_RETURN = 7;

const SELF_STORAGE = 0;
const ACCESSORY = 1;
const HANDY = 2;
const UNWEILDY = 3;
const SERVICES = 4;

const AVAILABLE = 0;

const LIST_STATUS_ORDER = [
  {'color': CustomColor.red, 'name': 'Đã Hủy'},
  {'color': CustomColor.blue, 'name': 'Đang vận chuyển'},
  {'color': CustomColor.green, 'name': 'Đã về kho'},
  {'color': CustomColor.red, 'name': 'Đã hết hạn'},
  {'color': CustomColor.green, 'name': 'Đã hoàn tất'},
  {'color': CustomColor.purple, 'name': 'Đang vận chuyển (trả)'},
  {'color': CustomColor.green, 'name': 'Đã hoàn tất'},
];

const LIST_ICON_REQUEST = [
  {'name': 'assets/images/truck1.png'},
  {'name': 'assets/images/invoice.png'},
  {'name': 'assets/images/extendOrder.png'},
  {'name': 'assets/images/error1.png'},
  {'name': 'assets/images/truck1.png'},
];

const LIST_STATUS_REQUEST = [
  {'name': 'Đã hủy', 'color': CustomColor.red},
  {'name': 'Đang xử lý', 'color': CustomColor.purple},
  {'name': 'Đã xử lý', 'color': CustomColor.blue},
  {'name': 'Hoàn thành', 'color': CustomColor.green},
  {'name': 'Đang vận chuyển', 'color': CustomColor.brown},
  {'name': 'Khách không có mặt', 'color': CustomColor.red},
];

const LIST_TYPE_REQUEST = [
  {'name': 'Hủy lịch giao hàng'},
  {'name': 'Tạo đơn'},
  {'name': 'Gia hạn đơn'},
  {'name': "Hủy đơn"},
  {'name': "Yêu cầu trả đơn"},
];

const LIST_TYPE_REQUES_DELIVERY = {
  1: {'name': 'Đi lấy hàng', "color": CustomColor.blue},
  4: {'name': 'Đi trả hàng', 'color': CustomColor.purple}
};

const List<Map<String, String>> TAB_DOOR_TO_DOOR = [
  {"name": "Ít đồ"},
  {"name": "Nhiều đồ"}
];

const List<String> LIST_TIME_PICK_UP = [
  "8am - 10am",
  "10am - 12pm",
  "12pm - 2pm",
  "2pm - 4pm",
  "4pm - 6pm",
];

const Map<int, String> LIST_URL_NOTFICATION = {
  0: 'assets/images/invoice.png',
  2: 'assets/images/invoice.png',
  3: 'assets/images/invoice.png',
  4: 'assets/images/invoice.png',
  1: 'assets/images/truck1.png',
  6: 'assets/images/invoice.png'
};

const Map<String, String> ICON_INVOICE = {
  "box": "assets/images/delivery-box1.png",
  "warehose": "assets/images/warehouse1.png"
};

const List<Map<String, dynamic>> LIST_ADDRESS_CHOICES = [
  {'name': 'Giống địa chỉ lấy đồ đạc', 'value': SelectDistrict.same},
  {'name': 'Khác địa chỉ lấy đồ đạc', 'value': SelectDistrict.different},
  {'name': 'Chưa xác định (Bổ sung sau)', 'value': SelectDistrict.notYet},
];

const List<Map<String, dynamic>> LIST_ADDRESS_PACKAGING_CHOICES = [
  {'name': 'Giống địa chỉ người thuê', 'value': SelectDistrict.same},
  {'name': 'Khác địa chỉ người thuê', 'value': SelectDistrict.different},
];

const List<Map<String, dynamic>> LIST_PAYMENT_METHOD_CHOICES = [
  {'name': 'Thanh toán tiền mặt', 'value': PAYMENT_METHOD.cash},
  {'name': 'Thánh toán thông qua paypal', 'value': PAYMENT_METHOD.paypal},
];

Map<bool, Map<String, dynamic>> mapIsPaid = {
  false: {'name': 'Chưa thanh toán', 'color': CustomColor.black[2]},
  true: {'name': 'Đã thanh toán', 'color': CustomColor.blue}
};
