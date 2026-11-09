import Route from "@ember/routing/route";
import { ajax } from "discourse/lib/ajax";

export default class DiscussionTransformerRoute extends Route {
  async beforeModel() {
    // The server rejects anyone who isn't in the inductors group.
    await ajax("/discussion-transformer/access.json");
  }
}

