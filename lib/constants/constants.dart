const List<Map<String, String>> LIST_CUSTOMER_BOTTOM_NAVIGATION = [
  {'url': "assets/images/profile.png", 'label': 'Profile'},
  {'url': "assets/images/addIcon.png", 'label': 'Cart'},
  {'url': "assets/images/notification.png", 'label': 'Notification'},
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

const List<Map<String, dynamic>> LIST_ACCESSORY = [
  {
    'url': 'assets/images/tape.png',
    'name': 'Băng keo trong',
    'id': 5,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/locker.png',
    'name': 'Ổ khóa cao cấp',
    'id': 6,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/peFoam.png',
    'name': 'Xốp hơi, xốp foam',
    'id': 7,
    'type': ACCESSORY
  },
  {
    'url': 'assets/images/PEstretchfilm.png',
    'name': 'Màn quấn PE',
    'id': 8,
    'type': ACCESSORY
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
      {"url": "assets/images/image28.png"},
      {"url": "assets/images/image28.png"},
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
      {"url": "assets/images/image27.png"},
      {"url": "assets/images/image28.png"},
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
      {"url": "assets/images/image27.png"},
      {"url": "assets/images/image28.png"},
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
      {"url": "assets/images/image27.png"},
      {"url": "assets/images/image28.png"},
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
      {"url": "assets/images/image27.png"},
      {"url": "assets/images/image28.png"},
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
    "statusCode": 1
  },
  {
    "url": "assets/images/error1.png",
    "requestId": "1312",
    "orderId": "1312",
    "status": "Chưa hoàn tiền",
    "statusCode": 2
  },
];
