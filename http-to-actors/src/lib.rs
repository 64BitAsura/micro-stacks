use wasmbus_rpc::actor::prelude::*;
use wasmcloud_interface_httpserver::{HttpRequest, HttpResponse, HttpServer, HttpServerReceiver};
use wasmcloud_interface_todo::{Todo, TodoSender, HttpRequest};

const TODO_ACTOR: &str = "wasmcloud/todo";

#[derive(Debug, Default, Actor, HealthResponder)]
#[services(Actor, HttpServer)]
struct HttpToActor {}

#[async_trait]
impl HttpServer for HttpToActor {
    async fn handle_request(&self, ctx: &Context, _req: &HttpRequest) -> RpcResult<HttpResponse> {
        let task_id = TodoSender::to_actor(TODO_ACTOR).handle_request(ctx,_req).await?;


        HttpResponse::ok(format!("AddTask {task_id}"))
    }
}