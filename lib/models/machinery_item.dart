class MachineryItem {
  final String id;
  final String title;
  final String specs; // e.g., '2018 | පැය 3200'
  final String price; // e.g., 'රු. 4,250,000'
  final String location; // e.g., 'කුරුණෑගල'
  final String type; // 'sale' or 'rent'
  final String badgeText;
  final String condition;
  final String tyreCondition;
  final String sellerPhone;
  bool isFavorite;

  MachineryItem({
    required this.id,
    required this.title,
    required this.specs,
    required this.price,
    required this.location,
    required this.type,
    required this.badgeText,
    this.condition = 'සුපිරි ධාවන තත්ත්වය (Excellent)',
    this.tyreCondition = '85% හොඳයි',
    this.sellerPhone = '077 456 7890',
    this.isFavorite = false,
  });

  static List<MachineryItem> getSampleItems() {
    return [
      MachineryItem(
        id: '1',
        title: 'JCB 3DX',
        specs: '2018 | පැය 3200',
        price: 'රු. 4,250,000',
        location: 'කුරුණෑගල',
        type: 'sale',
        badgeText: 'විකිණීමට',
      ),
      MachineryItem(
        id: '2',
        title: 'CAT 320D',
        specs: 'දිනක / මාසික',
        price: 'රු. 35,000 / දිනයකට',
        location: 'නුවර',
        type: 'rent',
        badgeText: 'කුලියට',
      ),
      MachineryItem(
        id: '3',
        title: 'ටාටා 315 E',
        specs: '2020 | පැය 1800',
        price: 'රු. 3,600,000',
        location: 'ගම්පහ',
        type: 'sale',
        badgeText: 'විකිණීමට',
      ),
    ];
  }
}
