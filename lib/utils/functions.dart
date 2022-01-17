import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Size size = MediaQuery.of(Get.context)
    .size; //Oran-orantı hesaplaması olarak ui tasarımlarında responsive uygulanması için kullanılan mediaquery yapısı.
Map<String, dynamic> parseJwt(String token) {
  if (token != null && token.isNotEmpty && token != '') {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  } else {
    return {'Hata': 'Token Data Boş'};
  }
}

String decodeBase64(String str) {
  var output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
