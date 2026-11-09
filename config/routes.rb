# frozen_string_literal: true

Discourse::Application.routes.append do
  get "/discussion-transformer/access" =>
    "discussion_transformer#access"

  get "/discussion-transformer/source" =>
    "discussion_transformer#source"

  post "/discussion-transformer/preview" =>
    "discussion_transformer#preview"

  post "/discussion-transformer/create" =>
    "discussion_transformer#create"
end

