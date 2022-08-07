import 'package:flutter/foundation.dart';

class NotificationsTotal extends ChangeNotifier {
  NotificationsTotal({required this.total});
  int? total;

  setTotal(int value) {
    total = value;
    notifyListeners();
  }

  reset(int index, String name) {
    total = 0;
    notifyListeners();
  }
}
