use serde_json::json;
use wasmbus_rpc::actor::prelude::*;
use wasmcloud_interface_todo::{HttpRequest, HttpResponse, Todo, TodoReceiver};

mod ui;
use ui::get_asset;

#[derive(Debug, Default, Actor, HealthResponder)]
#[services(Actor, Todo)]
struct TodoActor {}

/// Implementation of HttpServer trait methods
#[async_trait]
impl Todo for TodoActor {
    async fn handle_request(&self, ctx: &Context, req: &HttpRequest) -> RpcResult<HttpResponse> {
        let trimmed_path: Vec<&str> = req.path.trim_matches('/').split('/').collect();

        match (req.method.as_ref(), trimmed_path.as_slice()) {
            ("GET", ["api"]) => Ok(HttpResponse {
                body: "working".as_bytes().to_vec(),
                200,
                ..Default::default()
            }).await,
            // Any other GET request is interpreted as a static asset request for the UI
            ("GET", asset_path) => get_asset(asset_path.join("/")),
            (_, _) => Ok(HttpResponse::not_found()),
        }
    }
}
