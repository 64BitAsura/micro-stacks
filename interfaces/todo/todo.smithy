// todo.smithy
//

// Tell the code generator how to reference symbols defined in this namespace
metadata package = [ { namespace: "org.wasmcloud.interface.todo.todo", crate: "todo" } ]

namespace org.wasmcloud.interface.todo.todo

use org.wasmcloud.model#wasmbus
use org.wasmcloud.interface.httpserver#HttpRequest
use org.wasmcloud.interface.httpserver#HttpResponse

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
