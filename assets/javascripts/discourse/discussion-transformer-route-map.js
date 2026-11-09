export default {
  resource: "application",
  path: "/",
  map() {
    this.route("discussion-transformer");
  },
};

