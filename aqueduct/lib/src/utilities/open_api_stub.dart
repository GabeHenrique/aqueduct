// Minimal stub implementation for OpenAPI v3 functionality
// This replaces the missing 'package:open_api/v3.dart' dependency

/// Stub implementation for API document context
class APIDocumentContext {
  // Stub implementation - minimal functionality
}

/// Stub implementation for API schema object
class APISchemaObject {
  String? type;
  String? format;
  String? description;
  APISchemaObject? items;
  Map<String, APISchemaObject>? properties;
  List<String>? required;
  bool? nullable;
  dynamic example;
  
  APISchemaObject({
    this.type,
    this.format,
    this.description,
    this.items,
    this.properties,
    this.required,
    this.nullable,
    this.example,
  });
  
  // Factory constructors for common types
  APISchemaObject.integer({String? format, String? description, dynamic example}) 
    : this(type: 'integer', format: format, description: description, example: example);
    
  APISchemaObject.number({String? format, String? description, dynamic example})
    : this(type: 'number', format: format, description: description, example: example);
    
  APISchemaObject.string({String? format, String? description, dynamic example})
    : this(type: 'string', format: format, description: description, example: example);
    
  APISchemaObject.boolean({String? description, dynamic example})
    : this(type: 'boolean', description: description, example: example);
    
  APISchemaObject.array({APISchemaObject? ofSchema, String? description})
    : this(type: 'array', items: ofSchema, description: description);
    
  APISchemaObject.object({Map<String, APISchemaObject>? properties, String? description})
    : this(type: 'object', properties: properties, description: description);
}

/// Stub implementation for API document
class APIDocument {
  String? openapi;
  APIInfo? info;
  List<APIServer>? servers;
  Map<String, APIPath>? paths;
  APIComponents? components;
  
  APIDocument({
    this.openapi = '3.0.0',
    this.info,
    this.servers,
    this.paths,
    this.components,
  });
}

/// Stub implementation for API info
class APIInfo {
  String title;
  String version;
  String? description;
  
  APIInfo({
    required this.title,
    required this.version,
    this.description,
  });
}

/// Stub implementation for API server
class APIServer {
  String url;
  String? description;
  
  APIServer({
    required this.url,
    this.description,
  });
}

/// Stub implementation for API path
class APIPath {
  APIOperation? get;
  APIOperation? post;
  APIOperation? put;
  APIOperation? delete;
  APIOperation? patch;
  List<APIParameter>? parameters;
  
  APIPath({
    this.get,
    this.post,
    this.put,
    this.delete,
    this.patch,
    this.parameters,
  });
}

/// Stub implementation for API operation
class APIOperation {
  String? operationId;
  String? summary;
  String? description;
  List<String>? tags;
  List<APIParameter>? parameters;
  APIRequestBody? requestBody;
  Map<String, APIResponse>? responses;
  
  APIOperation({
    this.operationId,
    this.summary,
    this.description,
    this.tags,
    this.parameters,
    this.requestBody,
    this.responses,
  });
}

/// Stub implementation for API parameter
class APIParameter {
  String name;
  String location; // 'query', 'header', 'path', 'cookie'
  String? description;
  bool? required;
  APISchemaObject? schema;
  
  APIParameter({
    required this.name,
    required this.location,
    this.description,
    this.required,
    this.schema,
  });
  
  // Factory constructors for common parameter types
  APIParameter.query(String name, {String? description, bool? required, APISchemaObject? schema})
    : this(name: name, location: 'query', description: description, required: required, schema: schema);
    
  APIParameter.header(String name, {String? description, bool? required, APISchemaObject? schema})
    : this(name: name, location: 'header', description: description, required: required, schema: schema);
    
  APIParameter.path(String name, {String? description, APISchemaObject? schema})
    : this(name: name, location: 'path', description: description, required: true, schema: schema);
}

/// Stub implementation for API request body
class APIRequestBody {
  String? description;
  Map<String, APIMediaType>? content;
  bool? required;
  
  APIRequestBody({
    this.description,
    this.content,
    this.required,
  });
}

/// Stub implementation for API response
class APIResponse {
  String description;
  Map<String, APIMediaType>? content;
  Map<String, APIHeader>? headers;
  
  APIResponse({
    required this.description,
    this.content,
    this.headers,
  });
}

/// Stub implementation for API media type
class APIMediaType {
  APISchemaObject? schema;
  dynamic example;
  
  APIMediaType({
    this.schema,
    this.example,
  });
}

/// Stub implementation for API header
class APIHeader {
  String? description;
  APISchemaObject? schema;
  
  APIHeader({
    this.description,
    this.schema,
  });
}

/// Stub implementation for API components
class APIComponents {
  Map<String, APISchemaObject>? schemas;
  Map<String, APIResponse>? responses;
  Map<String, APIParameter>? parameters;
  Map<String, APIRequestBody>? requestBodies;
  Map<String, APIHeader>? headers;
  
  APIComponents({
    this.schemas,
    this.responses,
    this.parameters,
    this.requestBodies,
    this.headers,
  });
}

/// Stub implementation for component documenter
abstract class APIComponentDocumenter {
  void documentComponents(APIDocumentContext context);
}

/// Stub implementation for operation documenter
abstract class APIOperationDocumenter {
  Map<String, APIOperation> documentOperations(
      APIDocumentContext context, String route, APIPath path);
}

/// Stub implementation for parameter documenter
abstract class APIParameterDocumenter {
  List<APIParameter> documentOperationParameters(
      APIDocumentContext context, APIOperation operation);
}

/// Stub implementation for request body documenter
abstract class APIRequestBodyDocumenter {
  APIRequestBody? documentOperationRequestBody(
      APIDocumentContext context, APIOperation operation);
}

/// Stub implementation for response documenter
abstract class APIResponseDocumenter {
  Map<String, APIResponse> documentOperationResponses(
      APIDocumentContext context, APIOperation operation);
}