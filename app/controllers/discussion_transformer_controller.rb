# frozen_string_literal: true

class DiscussionTransformerController < ApplicationController
  before_action :ensure_inductor!

  def access
    render json: { ok: true }
  end

  def source
    topic = Topic.find_by(id: params[:topic_id])
    raise Discourse::NotFound unless topic && guardian.can_see?(topic)

    post = topic.first_post
    raise Discourse::NotFound unless post

    render json: {
      title: topic.title,
      raw: post.raw,
    }
  end

  def preview
    title = params[:title].to_s.strip
    raw = params[:raw].to_s

    return error_response("Title is required") if title.blank?
    return error_response("Body is required") if raw.blank?

    render json: build_preview(title, raw)
  end

  def create
    title = params[:title].to_s.strip
    raw = params[:raw].to_s
    category_id = Integer(params[:category_id], 10)

    return error_response("Title is required") if title.blank?
    return error_response("Body is required") if raw.blank?

    post = PostCreator.new(
      current_user,
      title: title,
      raw: raw,
      category: category_id
    ).create

    if post.is_a?(Post) && post.persisted?
      render json: { topic_url: post.topic.relative_url }
    else
      errors =
        post.respond_to?(:errors) ? post.errors.full_messages : ["Could not create topic"]

      render json: { errors: errors }, status: :unprocessable_entity
    end
  rescue ArgumentError, TypeError
    error_response("A valid destination category ID is required")
  end

  private

  INDUCTOR_GROUP_NAME = "inductors"

  def ensure_inductor!
    group = Group.find_by(name: INDUCTOR_GROUP_NAME)
    member = current_user && group&.users&.where(id: current_user.id)&.exists?

    raise Discourse::NotFound unless member
  end

  def build_preview(title, raw)
    # TODO: Apply the README's transformation rules here.
    { title: title, raw: raw }
  end

  def error_response(message)
    render json: { errors: [message] }, status: :unprocessable_entity
  end
end

