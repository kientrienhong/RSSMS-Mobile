import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';

enum REQUEST_TYPE {
  cancelSchedule,
  createOrder,
  extendOrder,
  cancelRequestCreateOrder,
  returnOrder
}
enum STATUS_INVOICE { booked, assigned, deliveried, stored, expired, done }

enum STATUS_REQUEST { canceled, inProcess, processed, completed }

enum ADDITION_FEE_TYPE {
  takingAdditionFee,
  returningAdditionFee,
  compensationFee
}

const List<Map<String, String>> tabInvoiceDetail = [
  {"name": "Hóa đơn"},
  {"name": "Đồ đạc"}
];

const doorToDoorTypeOrder = 1;
const selfStorageTypeOrder = 0;

const List<Map<String, String>> listCustomerBottomNavigation = [
  {'url': "assets/images/profile.png", 'label': 'Thông tin tài khoản'},
  {'url': "assets/images/addIcon.png", 'label': 'Giỏ hàng'},
  {'url': "assets/images/notification.png", 'label': 'Thông báo'},
];

const List<Map<String, String>> listDeliveryBottomNavigation = [
  {'url': "assets/images/profile.png", 'label': 'Thông tin tài khoản'},
  {'url': "assets/images/deliveryNav.png", 'label': 'Lịch giao'},
  {'url': "assets/images/qrCode.png", 'label': 'QR'},
  {'url': "assets/images/notification.png", 'label': 'Thông báo'},
];

const List<Map<String, String>> listOfficeBottomNavigation = [
  {'url': "assets/images/profile.png", 'label': 'Thông tin tài khoản'},
  {'url': "assets/images/qrCode.png", 'label': 'QR'},
  {'url': "assets/images/paper.png", 'label': 'Đơn hàng'},
  {'url': "assets/images/storage.png", 'label': 'Kho'},
];

const doorToDoorTab = 0;
const selfStorageTab = 1;

const requestTypeCancelSchedule = 0;
const requestTypeCreateOrder = 1;
const requestTypeExtendOrder = 2;
const requestTypeCancelOrder = 3;
const requestTypeReturnOrder = 4;

enum typeProduct { selfStorage, accessory, handy, unweildy, services }

const listStatusOrder = [
  {'color': CustomColor.red, 'name': 'Đã Hủy'},
  {'color': CustomColor.blue, 'name': 'Đang vận chuyển'},
  {'color': CustomColor.green, 'name': 'Đã về kho'},
  {'color': CustomColor.orange, 'name': 'Sắp hết hạn'},
  {'color': CustomColor.red, 'name': 'Đã quá hạn'},
  {'color': CustomColor.red, 'name': 'Đang thanh lý'},
  {'color': CustomColor.green, 'name': 'Đã hoàn tất'},
  {'color': CustomColor.red, 'name': 'Đã thanh lý'},
];

const listAreaType = [
  {'color': CustomColor.purple, 'name': 'Kho tự quản'},
  {'color': CustomColor.blue, 'name': 'Giữ đồ thuê'},
];

const listSpaceType = [
  {'color': CustomColor.blue, 'name': 'Không gian chứa đồ'},
  {'color': CustomColor.purple, 'name': 'Kho'},
];

const listIconRequest = [
  {'name': 'assets/images/truck1.png'},
  {'name': 'assets/images/invoice.png'},
  {'name': 'assets/images/extendOrder.png'},
  {'name': 'assets/images/error1.png'},
  {'name': 'assets/images/truck1.png'},
];

const listRequestStatus = [
  {'name': 'Đã hủy', 'color': CustomColor.red},
  {'name': 'Đang xử lý', 'color': CustomColor.purple},
  {'name': 'Đã xử lý', 'color': CustomColor.blue},
  {'name': 'Hoàn thành', 'color': CustomColor.green},
  {'name': 'Đang vận chuyển', 'color': CustomColor.brown},
  {'name': 'Khách không có mặt', 'color': CustomColor.red},
  {'name': 'Đã xử lý', 'color': CustomColor.blue},
];

const listRequestType = [
  {'name': 'Hủy lịch giao hàng'},
  {'name': 'Tạo đơn'},
  {'name': 'Gia hạn đơn'},
  {'name': "Hủy đơn"},
  {'name': "Yêu cầu trả đơn"},
];

const listDeliveryRequestType = {
  1: {'name': 'Đi lấy hàng', "color": CustomColor.blue},
  4: {'name': 'Đi trả hàng', 'color': CustomColor.purple}
};

const List<Map<String, String>> tabDoorToDoor = [
  {"name": "Gửi theo loại"},
  {"name": "Gửi theo diện tích"}
];

const List<String> listPickUpTime = [
  "8am - 10am",
  "10am - 12pm",
  "12pm - 2pm",
  "2pm - 4pm",
  "4pm - 6pm",
];

const Map<int, String> listNotificationURL = {
  0: 'assets/images/invoice.png',
  2: 'assets/images/invoice.png',
  3: 'assets/images/invoice.png',
  4: 'assets/images/invoice.png',
  1: 'assets/images/truck1.png',
  6: 'assets/images/invoice.png'
};

const Map<String, String> invoiceIcons = {
  "box": "assets/images/delivery-box1.png",
  "warehose": "assets/images/warehouse1.png"
};

const List<Map<String, dynamic>> listPaymentMethodChoices = [
  {'name': 'Thanh toán tiền mặt', 'value': PAYMENT_METHOD.cash},
  {'name': 'Thánh toán thông qua paypal', 'value': PAYMENT_METHOD.paypal},
];

Map<bool, Map<String, dynamic>> mapIsPaid = {
  false: {
    'name': 'Chưa thanh toán',
    'color': CustomColor.black[3],
  },
  true: {'name': 'Đã thanh toán', 'color': CustomColor.blue}
};
