import Route from "@ember/routing/route";

export default class DiscussionTransformerRoute extends Route {
  model() {
    return {
      message: "Your plugin page is working!",
    };
  }
}

