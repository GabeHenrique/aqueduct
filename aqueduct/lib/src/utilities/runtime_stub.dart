// Minimal stub implementation for runtime package functionality
// This replaces the missing 'package:runtime/runtime.dart' dependency

import 'dart:isolate';
import 'dart:mirrors';

/// Stub implementation for Runtime functionality
abstract class Runtime {
  static Runtime? get instance => null;
}

/// Stub implementation for RuntimeContext
abstract class RuntimeContext {
  static RuntimeContext? get current => _currentContext;
  static RuntimeContext? _currentContext;
  
  // Operator to access context by type
  dynamic operator [](Type type) => null;
}

/// Stub implementation for SourceCompiler
abstract class SourceCompiler {
  String get name => "unknown";
}

/// Stub implementation for various runtime exceptions
class RuntimeException implements Exception {
  final String message;
  RuntimeException(this.message);
  
  @override
  String toString() => "RuntimeException: $message";
}

/// Stub implementation for code generation context
class CodeGenerationContext {
  // Stub implementation - no-op
}

/// Stub implementation for compiler context
class CompilerContext {
  // Stub implementation - no-op
}