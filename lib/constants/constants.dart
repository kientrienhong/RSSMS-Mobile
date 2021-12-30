import 'package:rssms/pages/customers/input_information_booking/input_information.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';

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

const List<Map<String, String>> TAB_DOOR_TO_DOOR = [
  {"name": "Ít đồ"},
  {"name": "Nhiều đồ"}
];

const List<Map<String, dynamic>> LIST_PRODUCT = [
  {'url': 'assets/images/bolobox.png', 'name': 'Bolo', 'id': 0, 'price': 10000},
  {
    'url': 'assets/images/boxSizeS.png',
    'name': 'Size S',
    'id': 1,
    'price': 20000,
    'type': HANDY
  },
  {
    'url': 'assets/images/boxSizeM.png',
    'name': 'Size M',
    'id': 2,
    'price': 30000,
    'type': HANDY
  },
  {
    'url': 'assets/images/boxSizeL.png',
    'name': 'Size L',
    'id': 3,
    'price': 40000,
    'type': HANDY
  },
  {
    'url': 'assets/images/boxSizeXL.png',
    'name': 'Size XL',
    'id': 4,
    'price': 50000,
    'type': HANDY
  },
];

const List<Map<String, dynamic>> LIST_SELF_STORAGE = [
  {
    'url': 'assets/images/8m2.png',
    'name': 'Kho 8m2',
    'id': 10,
    'price': 10000,
    'type': SELF_STORAGE
  },
  {
    'url': 'assets/images/16m2.png',
    'name': 'Kho 16m2',
    'id': 11,
    'price': 20000,
    'type': SELF_STORAGE
  },
];

const List<Map<String, dynamic>> LIST_ACCESSORY = [
  {
    'url': 'assets/images/tape.png',
    'name': 'Băng keo trong',
    'id': 5,
    'price': 20000,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/locker.png',
    'name': 'Ổ khóa cao cấp',
    'id': 6,
    'price': 20000,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/peFoam.png',
    'name': 'Xốp hơi, xốp foam',
    'id': 7,
    'price': 20000,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/PEstretchfilm.png',
    'name': 'Màn quấn PE',
    'id': 8,
    'price': 20000,
    'type': ACCESSORY
  },
];

const List<Map<String, dynamic>> LIST_SERVICES = [
  {
    'url': 'assets/images/packaging.png',
    'name': 'Đóng gói dễ vỡ',
    'id': 9,
    'price': 20000,
    'type': SERVICES
  },
];

const List<String> LIST_TIME_PICK_UP = [
  "8am - 10am",
  "10am - 12pm",
  "12pm - 2pm",
  "2pm - 4pm",
  "4pm - 6pm",
];

const List<Map<String, dynamic>> LIST_INVOICE = [
  {
    "url": "assets/images/delivery-box1.png",
    "id": "1312",
    "getDate": "12/12/2021",
    "address": "2 Gia Phu, Phuong 13, Quan 5, TP Ho Chi Minh",
    "returnnDate": "12/12/2021",
    "status": "Đã thanh toán",
    "discount": "Không có",
    "month": 1,
    "quantity": 1,
    "totalPrice": 190000,
    "totalItem": 140000,
    "item": [
      {
        "name": "Size S",
        "quantity": 1,
        "url": "assets/images/boxSizeS.png",
        "price": 70000
      },
      {
        "name": "Size L",
        "quantity": 1,
        "url": "assets/images/boxSizeL.png",
        "price": 70000
      },
    ],
    "accessory": [
      {
        "name": "Băng keo trong",
        "quantity": 1,
        "url": "assets/images/tape.png",
        "price": 25000
      },
      {
        "name": "Xốp hơi, xốp foam",
        "quantity": 1,
        "url": "assets/images/peFoam.png",
        "price": 25000
      },
    ],
    "statusCode": 1,
    "image": [
      {"url": "assets/images/image28.png", "name": 'Box 1', 'id': 1},
      {"url": "assets/images/image27.png", "name": 'Box 2', 'id': 2},
    ],
    "type": 0
  },
  {
    "url": "assets/images/warehouse1.png",
    "id": "2546",
    "getDate": "12/12/2021",
    "address": "2 Gia Phu, Phuong 13, Quan 5, TP Ho Chi Minh",
    "returnnDate": "12/12/2021",
    "discount": "Không có",
    "totalPrice": 190000,
    "totalItem": 140000,
    "month": 1,
    "quantity": 1,
    "item": [
      {
        "name": "Size S",
        "quantity": 1,
        "url": "assets/images/boxSizeS.png",
        "price": 70000
      },
      {
        "name": "Size L",
        "quantity": 1,
        "url": "assets/images/boxSizeL.png",
        "price": 70000
      },
    ],
    "accessory": [
      {
        "name": "Băng keo trong",
        "quantity": 1,
        "url": "assets/images/tape.png",
        "price": 25000
      },
      {
        "name": "Xốp hơi, xốp foam",
        "quantity": 1,
        "url": "assets/images/peFoam.png",
        "price": 25000
      },
    ],
    "status": "Đã thanh toán",
    "statusCode": 1,
    "image": [
      {"url": "assets/images/image28.png", "name": 'Box 1', 'id': 1},
      {"url": "assets/images/image27.png", "name": 'Box 2', 'id': 2},
    ],
    "type": 1
  },
  {
    "url": "assets/images/warehouse1.png",
    "id": "8456",
    "getDate": "12/12/2021",
    "address": "2 Gia Phu, Phuong 13, Quan 5, TP Ho Chi Minh",
    "returnnDate": "12/12/2021",
    "discount": "Không có",
    "totalPrice": 190000,
    "totalItem": 140000,
    "month": 1,
    "quantity": 1,
    "item": [
      {
        "name": "Size S",
        "quantity": 1,
        "url": "assets/images/boxSizeS.png",
        "price": 70.000
      },
      {
        "name": "Size L",
        "quantity": 1,
        "url": "assets/images/boxSizeL.png",
        "price": 70.000
      },
    ],
    "accessory": [
      {
        "name": "Băng keo trong",
        "quantity": 1,
        "url": "assets/images/tape.png",
        "price": 25000
      },
      {
        "name": "Xốp hơi, xốp foam",
        "quantity": 1,
        "url": "assets/images/peFoam.png",
        "price": 25000
      },
    ],
    "status": "Sắp hết hạn",
    "statusCode": 2,
    "image": [
      {"url": "assets/images/image28.png", "name": 'Box 1', 'id': 1},
      {"url": "assets/images/image27.png", "name": 'Box 2', 'id': 2},
    ],
    "type": 1
  },
  {
    "url": "assets/images/warehouse1.png",
    "id": "1225",
    "getDate": "12/12/2021",
    "address": "2 Gia Phu, Phuong 13, Quan 5, TP Ho Chi Minh",
    "returnnDate": "12/12/2021",
    "discount": "Không có",
    "totalPrice": 190000,
    "totalItem": 140000,
    "month": 1,
    "quantity": 1,
    "item": [
      {
        "name": "Size S",
        "quantity": 1,
        "url": "assets/images/boxSizeS.png",
        "price": 70.000
      },
      {
        "name": "Size L",
        "quantity": 1,
        "url": "assets/images/boxSizeL.png",
        "price": 70000
      },
    ],
    "accessory": [
      {
        "name": "Băng keo trong",
        "quantity": 1,
        "url": "assets/images/tape.png",
        "price": 25000
      },
      {
        "name": "Xốp hơi, xốp foam",
        "quantity": 1,
        "url": "assets/images/peFoam.png",
        "price": 25000
      },
    ],
    "status": "Đã hết hạn",
    "statusCode": 3,
    "image": [
      {"url": "assets/images/image28.png", "name": 'Box 1', 'id': 1},
      {"url": "assets/images/image27.png", "name": 'Box 2', 'id': 2},
    ],
    "type": 1
  },
  {
    "url": "assets/images/warehouse1.png",
    "id": "1225",
    "getDate": "12/12/2021",
    "address": "2 Gia Phu, Phuong 13, Quan 5, TP Ho Chi Minh",
    "returnnDate": "12/12/2021",
    "discount": "Không có",
    "totalPrice": 190000,
    "totalItem": 140000,
    "month": 1,
    "quantity": 1,
    "item": [
      {
        "name": "Size S",
        "quantity": 1,
        "url": "assets/images/boxSizeS.png",
        "price": 70000
      },
      {
        "name": "Size L",
        "quantity": 1,
        "url": "assets/images/boxSizeL.png",
        "price": 70000
      },
    ],
    "accessory": [
      {
        "name": "Băng keo trong",
        "quantity": 1,
        "url": "assets/images/tape.png",
        "price": 25000
      },
      {
        "name": "Xốp hơi, xốp foam",
        "quantity": 1,
        "url": "assets/images/peFoam.png",
        "price": 25000
      },
    ],
    "status": "Đã hết hạn",
    "statusCode": 3,
    "image": [
      {"url": "assets/images/image28.png", "name": 'Box 1', 'id': 1},
      {"url": "assets/images/image27.png", "name": 'Box 2', 'id': 2},
    ],
    "type": 1
  },
];

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
  {
    'name': 'Ứng dụng Mobile Banking quét mã VNPAY QR',
    'value': PAYMENT_METHOD.mobileBanking
  },
  {'name': 'Thẻ ATM và tài khoản ngân hàng', 'value': PAYMENT_METHOD.ATM},
  {'name': 'Thẻ thanh toán quốc tế', 'value': PAYMENT_METHOD.visa},
  {'name': 'Ví điện tử', 'value': PAYMENT_METHOD.eWallet},
];

const List<Map<String, dynamic>> LIST_PAYMENT_EACH_MONTH_CHOICES = [
  {
    'name':
        'Thanh toán toàn bộ đơn hàng\n\n- Đối với đơn hàng dưới 1 tháng\n\n-Giảm 10% đối với đơn hàng trên 1 tháng',
    'value': PAYMENT_EACH_MONTHS_METHODS.YES
  },
  {
    'name':
        'Thanh toán theo từng tháng\n\n- Không áp dụng với đơn hàng dưới 1 tháng\n\n- Thanh toán ngay: chi phí tháng đầu tiên + chi phí khác: nếu có\n\n- Các tháng sau, chi phí sẽ thanh toán theo từng tháng vào ngày thứ 30 của tháng gửi giữ',
    'value': PAYMENT_EACH_MONTHS_METHODS.NO
  },
];

const List<Map<String, dynamic>> LIST_SCHEDULE_DELIVERY = [
  {
    'id': 0,
    'time': '8 a.m - 10 a.m',
    'order': {
      'id': 321,
      'status': ORDER_STATUS.notYet,
      'address': '12 An Bình, phường 13, quận 9, TP. HCM',
      'customerName': 'Trần Văn A',
      'customerPhone': '0777457890'
    }
  },
  {
    'id': 1,
    'time': '10 a.m - 12 a.m',
    'order': {
      'id': 322,
      'status': ORDER_STATUS.completed,
      'address': '12 An Bình, phường 13, quận 9, TP. HCM',
      'customerName': 'Trần Văn B',
      'customerPhone': '0777457259'
    }
  }
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
    'timeRemaining': '10m'
  },
  {
    'id': 2,
    'content': 'Đơn hàng #1233 của bạn sắp hết hạn',
    'timeRemaining': '10m'
  },
];
