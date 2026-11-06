import RouteTemplate from "ember-route-template";

export default RouteTemplate(
  <template>
    <main>
      <h1>Discussion Transformer</h1>
      <p>{{@model.message}}</p>
    </main>
  </template>
);

