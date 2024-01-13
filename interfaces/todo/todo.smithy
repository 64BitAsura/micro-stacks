// todo.smithy
//

// Tell the code generator how to reference symbols defined in this namespace
metadata package = [ { namespace: "org.wasmcloud.interface.todo.todo", crate: "todo" } ]

namespace org.wasmcloud.interface.todo.todo

use org.wasmcloud.model#wasmbus

/// Description of Todo service
@wasmbus( actorReceive: true )
service Todo {
    version: "0.1",
  operations: [ HandleRequest ]
}

operation HandleRequest {
  input: HttpRequest,
  output: HttpResponse,
}

/// HttpRequest contains data sent to actor about the http request
structure HttpRequest {

  /// HTTP method. One of: GET,POST,PUT,DELETE,HEAD,OPTIONS,CONNECT,PATCH,TRACE
  @required
  @n(0)
  method: String,

  /// full request path
  @required
  @n(1)
  path: String,

  /// query string. May be an empty string if there were no query parameters.
  @required
  @n(2)
  queryString: String,

  /// map of request headers (string key, string value)
  @required
  @n(3)
  header: HeaderMap,

  /// Request body as a byte array. May be empty.
  @required
  @n(4)
  body: Blob,
}

/// HttpResponse contains the actor's response to return to the http client
// don't generate Default so we can customize it
@codegenRust( noDeriveDefault: true )
structure HttpResponse {
  /// statusCode is a three-digit number, usually in the range 100-599,
  /// A value of 200 indicates success.
  @required
  @n(0)
  statusCode: U16,

  /// Map of headers (string keys, list of values)
  @required
  @n(1)
  header: HeaderMap,

  /// Body of response as a byte array. May be an empty array.
  @required
  @n(2)
  body: Blob,
}

/// map data structure for holding http headers
///
map HeaderMap {
    key: String,
    value: HeaderValues,
}

list HeaderValues {
    member: String
}