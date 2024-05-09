import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Conversor {
  static ImageProvider convertBase64ToImage(String base64String) {
    Uint8List decodedBytes = base64Decode(base64String);
    return MemoryImage(decodedBytes);
  }
}
