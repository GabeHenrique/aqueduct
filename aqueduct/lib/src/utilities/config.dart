// Simple replacement for safe_config functionality
// This provides basic configuration parsing without the full safe_config features

import 'dart:io';
import 'package:yaml/yaml.dart';

/// A simple configuration class that can read from environment variables and YAML files
abstract class Configuration {
  /// Creates a configuration instance from a file
  static T fromFile<T extends Configuration>(String path, T Function() constructor) {
    final file = File(path);
    if (!file.existsSync()) {
      throw ArgumentError('Configuration file not found: $path');
    }
    
    final content = file.readAsStringSync();
    final yaml = loadYaml(content);
    
    final instance = constructor();
    if (yaml is Map) {
      instance._readFromMap(yaml.cast<String, dynamic>());
    }
    
    return instance;
  }
  
  /// Creates a configuration instance from environment variables
  static T fromEnvironment<T extends Configuration>(T Function() constructor) {
    final instance = constructor();
    instance._readFromEnvironment();
    return instance;
  }
  
  void _readFromMap(Map<String, dynamic> map) {
    // Subclasses should override this to read their specific configuration
  }
  
  void _readFromEnvironment() {
    // Subclasses should override this to read from environment variables
  }
}

/// A simple database configuration class
class DatabaseConfiguration extends Configuration {
  String? host;
  int? port;
  String? username;
  String? password;
  String? databaseName;
  bool? useSSL;
  
  DatabaseConfiguration();
  
  @override
  void _readFromMap(Map<String, dynamic> map) {
    host = map['host'] as String?;
    port = map['port'] as int?;
    username = map['username'] as String?;
    password = map['password'] as String?;
    databaseName = map['databaseName'] as String?;
    useSSL = map['useSSL'] as bool?;
  }
  
  @override
  void _readFromEnvironment() {
    host = Platform.environment['DB_HOST'];
    final portStr = Platform.environment['DB_PORT'];
    if (portStr != null) {
      port = int.tryParse(portStr);
    }
    username = Platform.environment['DB_USERNAME'];
    password = Platform.environment['DB_PASSWORD'];
    databaseName = Platform.environment['DB_NAME'];
    final useSslStr = Platform.environment['DB_USE_SSL'];
    if (useSslStr != null) {
      useSSL = useSslStr.toLowerCase() == 'true';
    }
  }
}