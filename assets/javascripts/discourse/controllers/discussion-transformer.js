import Controller from "@ember/controller";
import { action } from "@ember/object";
import { tracked } from "@glimmer/tracking";
import { ajax } from "discourse/lib/ajax";

export default class DiscussionTransformerController extends Controller {
  @tracked topicId = "";
  @tracked categoryId = "";
  @tracked title = "";
  @tracked raw = "";
  @tracked preview = null;
  @tracked publishedUrl = null;
  @tracked error = null;
  @tracked busy = false;

  @action
  updateField(field, event) {
    this[field] = event.target.value;
    this.error = null;
    this.publishedUrl = null;
  }

  @action
  async loadSource() {
    this.busy = true;
    this.error = null;

    try {
      const result = await ajax("/discussion-transformer/source.json", {
        data: { topic_id: this.topicId },
      });

      this.title = result.title;
      this.raw = result.raw;
      this.preview = null;
    } catch (error) {
      this.error =
        error?.jqXHR?.responseJSON?.errors?.join(", ") ||
        "Could not load that topic.";
    } finally {
      this.busy = false;
    }
  }

  @action
  async previewPost() {
    this.busy = true;
    this.error = null;

    try {
      this.preview = await ajax("/discussion-transformer/preview.json", {
        type: "POST",
        data: { title: this.title, raw: this.raw },
      });
    } catch (error) {
      this.error =
        error?.jqXHR?.responseJSON?.errors?.join(", ") ||
        "Could not generate the preview.";
    } finally {
      this.busy = false;
    }
  }

  @action
  async publish() {
    this.busy = true;
    this.error = null;
    this.publishedUrl = null;

    try {
      const result = await ajax("/discussion-transformer/create.json", {
        type: "POST",
        data: {
          category_id: this.categoryId,
          title: this.title,
          raw: this.raw,
        },
      });

      this.publishedUrl = result.topic_url;
    } catch (error) {
      this.error =
        error?.jqXHR?.responseJSON?.errors?.join(", ") ||
        "Could not publish the topic.";
    } finally {
      this.busy = false;
    }
  }
}

