# name: discourse-discussion-transformer
# about: Tool used to create discourse
# version: 0.0.1
# authors: Destom
# url: https://github.com/d3stom/discourse-discussion-transformer

Discourse::Application.routes.append do
  get "/discussion-transformer" => "list#latest"

  get "/discussion-transformer/access" =>
    "discussion_transformer#access"

  get "/discussion-transformer/source" =>
    "discussion_transformer#source"

  post "/discussion-transformer/preview" =>
    "discussion_transformer#preview"

  post "/discussion-transformer/create" =>
    "discussion_transformer#create"
end

