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
