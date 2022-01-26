import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';
import 'package:rssms/pages/delivery_staff/request/widgets/request_widget.dart';

const List<Map<String, String>> LIST_CUSTOMER_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/addIcon.png", 'label': 'Cart'},
  {'url': "assets/images/notification.png", 'label': 'Notification'},
];

const List<Map<String, String>> LIST_DELIVERY_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/deliveryNav.png", 'label': 'Schedule'},
  {'url': "assets/images/qrCode.png", 'label': 'QR'},
  {'url': "assets/images/notification.png", 'label': 'Notifcation'},
];

const DOOR_TO_DOOR_TAB = 0;
const SELF_STORAGE_TAB = 0;

const TYPE_PRODUCT = {
  "SELF_STORAGE": 0,
  'ACCESSORY': 1,
  'HANDY': 2,
  'UNWEILDY': 4,
  'SERVICES': 3,
};

// STATUS_INVOICE
const PAID = 1;
const EXPIRED_SOON = 2;
const EXPIRED = 3;

const SELF_STORAGE = 0;
const ACCESSORY = 1;
const HANDY = 2;
const UNWEILDY = 4;
const SERVICES = 3;

const AVAILABLE = 0;
const LIST_NOTE_STATUS_BOX = [
  {'color': CustomColor.brightBlue, 'name': 'Available'},
  {'color': CustomColor.blue, 'name': 'Rented'},
  {'color': CustomColor.red, 'name': 'Expired'},
  {'color': CustomColor.orange, 'name': 'Expired soon'},
  {'color': CustomColor.greenBright, 'name': 'Selected'},
  {'color': CustomColor.green, 'name': 'Placing'},
];

const LIST_STATUS_ORDER = [
  {'color': CustomColor.red, 'name': 'Hủy'},
  {'color': CustomColor.purple, 'name': 'Đang xử lý'},
  {'color': CustomColor.blue, 'name': 'Đã được xử lý'},
  {'color': CustomColor.blue, 'name': 'Đang vận chuyển'},
  {'color': CustomColor.green, 'name': 'Đã về kho'},
  {'color': CustomColor.red, 'name': 'Đã hết hạn'},
];

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

const Map<String, String> ICON_INVOICE = {
  "box": "assets/images/delivery-box1.png",
  "warehose": "assets/images/warehouse1.png"
};

const List<Map<String, dynamic>> LIST_REQUEST = [
  {
    "url": "assets/images/truck1.png",
    "requestId": "1312",
    "orderId": "1312",
    "dateChange": "12/12/2021",
    "status": "Đang giao hàng",
    'type': REQUEST_TYPE.modifyRequest,
  },
  {
    "url": "assets/images/error1.png",
    "requestId": "1312",
    "orderId": "1312",
    "status": "Chưa hoàn tiền",
    'type': REQUEST_TYPE.cancelOrderRequest,
  },
];

const List<Map<String, dynamic>> LIST_ADDRESS_CHOICES = [
  {'name': 'Giống địa chỉ lấy đồ đạc', 'value': SelectDistrict.same},
  {'name': 'Khác địa chỉ lấy đồ đạc', 'value': SelectDistrict.different},
  {'name': 'Chưa xác định (Bổ sung sau)', 'value': SelectDistrict.notYet},
];

const List<Map<String, dynamic>> LIST_ADDRESS_PACKAGING_CHOICES = [
  {'name': 'Giống địa chỉ người thuê', 'value': SelectDistrict.same},
  {'name': 'Khác địa chỉ người thuê', 'value': SelectDistrict.different},
];

const List<Map<String, dynamic>> LIST_CHOICE_NOTED_BOOKING = [
  {'name': 'Hàng cồng kềnh', 'url': 'assets/images/unweildy.png'},
  {'name': 'Hàng nặng', 'url': 'assets/images/weighty.png'},
  {'name': 'Hàng dễ vỡ', 'url': 'assets/images/vulnerable.png'},
  {
    'name': 'Hẻm nhỏ (xe tải không vào được)',
    'url': 'assets/images/narrow.png'
  },
  {
    'name': 'Nhà nhiều tầng không thang máy',
    'url': 'assets/images/building.png'
  },
  {'name': 'Không chỗ đậu xe', 'url': 'assets/images/noParking.png'},
];

const List<Map<String, dynamic>> LIST_PAYMENT_METHOD_CHOICES = [
  {'name': 'Thanh toán tiền mặt', 'value': PAYMENT_METHOD.cash},
  {'name': 'Thánh toán thông qua paypal', 'value': PAYMENT_METHOD.paypal},
];

const List<Map<String, dynamic>> LIST_REQUEST_MODIFY_IMAGE = [
  {
    'id': 1,
    'url': 'assets/images/image28.png',
    'name': 'Box 2',
    'note': 'dasd',
  }
];

const List<Map<String, dynamic>> LIST_TIME_LINE_MODIFY = [
  {'id': 1, 'name': 'Đã gửi yêu cầu', 'date': '20/12', 'time': '10:32'},
  {'id': 1, 'name': 'Đang vận chuyển', 'date': '22/12', 'time': '11:00'},
  {'id': 1, 'name': 'Bàn giao đồ', 'date': '28/12', 'time': '10:43'},
];

const List<Map<String, dynamic>> LIST_NOTIFICATION_DELIVERY = [
  {
    'id': 1,
    'content': 'Đơn hàng #1233 của bạn đã được lưu trữ trong kho',
    'timeRemaining': '10m',
    'url': 'assets/images/truck1.png'
  },
  {
    'id': 2,
    'content': 'Đơn hàng #1233 của bạn sắp hết hạn',
    'timeRemaining': '10m',
    'url': 'assets/images/dangerCircle.png'
  },
];
