import 'package:exam/data/ar-EG.dart';
import 'package:exam/data/en-US.dart';
import 'package:get/get.dart';

class Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'en':en,'ar':ar
  };

}

