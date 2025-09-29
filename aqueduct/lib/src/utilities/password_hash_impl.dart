// Null-safe replacement for password_hash package functionality
// Implements PBKDF2 password hashing and salt generation

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// PBKDF2 password-based key derivation function implementation
class PBKDF2 {
  /// The hash algorithm to use for key derivation
  final Hash hashAlgorithm;

  /// Creates a PBKDF2 instance with the specified hash algorithm
  PBKDF2({required this.hashAlgorithm});

  /// Generates a base64-encoded key using PBKDF2
  String generateBase64Key(String password, String salt, int iterations, int keyLength) {
    final passwordBytes = utf8.encode(password);
    final saltBytes = utf8.encode(salt);
    
    final key = _pbkdf2(passwordBytes, saltBytes, iterations, keyLength);
    return base64.encode(key);
  }

  /// Internal PBKDF2 implementation
  Uint8List _pbkdf2(List<int> password, List<int> salt, int iterations, int keyLength) {
    final hmac = Hmac(hashAlgorithm, password);
    final result = Uint8List(keyLength);
    
    final blockCount = (keyLength / hashAlgorithm.convert([]).bytes.length).ceil();
    
    for (int i = 1; i <= blockCount; i++) {
      final block = _generateBlock(hmac, salt, iterations, i);
      final offset = (i - 1) * hashAlgorithm.convert([]).bytes.length;
      final length = math.min(block.length, keyLength - offset);
      
      result.setRange(offset, offset + length, block);
    }
    
    return result.sublist(0, keyLength);
  }

  /// Generates a single PBKDF2 block
  Uint8List _generateBlock(Hmac hmac, List<int> salt, int iterations, int blockIndex) {
    // Convert block index to big-endian bytes
    final blockBytes = Uint8List(4);
    blockBytes[0] = (blockIndex >> 24) & 0xff;
    blockBytes[1] = (blockIndex >> 16) & 0xff;
    blockBytes[2] = (blockIndex >> 8) & 0xff;
    blockBytes[3] = blockIndex & 0xff;
    
    // First iteration: HMAC(salt + block_index)
    var u = Uint8List.fromList(hmac.convert([...salt, ...blockBytes]).bytes);
    final result = Uint8List.fromList(u);
    
    // Subsequent iterations
    for (int i = 1; i < iterations; i++) {
      u = Uint8List.fromList(hmac.convert(u).bytes);
      for (int j = 0; j < result.length; j++) {
        result[j] ^= u[j];
      }
    }
    
    return result;
  }
}

/// Salt generation utilities
class Salt {
  static final _random = Random.secure();

  /// Generates a random salt as a base64 string
  static String generateAsBase64String(int length) {
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return base64.encode(bytes);
  }
}