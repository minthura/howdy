import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

extension TemperatureUtils on String {
  String switchMMNumber(BuildContext context) {
    if (context.locale.toString() != 'my_MM') {
      return this;
    }
    Map<String, String> map = {
      '1': '၁',
      '2': '၂',
      '3': '၃',
      '4': '၄',
      '5': '၅',
      '6': '၆',
      '7': '၇',
      '8': '၈',
      '9': '၉',
      '0': '၀'
    };
    var text = this;
    map.forEach((key, value) {
      text = text.replaceAll(key, value);
    });
    return text;
  }
}
