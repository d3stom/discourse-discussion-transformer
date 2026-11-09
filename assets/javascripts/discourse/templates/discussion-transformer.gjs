<template>
  <div class="discussion-transformer">
    <h1>Discussion Transformer</h1>

    <label for="source-topic-id">Source topic ID</label>
    <input
      id="source-topic-id"
      value={{@controller.topicId}}
      {{on "input" (fn @controller.updateField "topicId")}}
    />
    <button
      type="button"
      disabled={{@controller.busy}}
      {{on "click" @controller.loadSource}}
    >
      Load source
    </button>

    <label for="category-id">Destination category ID</label>
    <input
      id="category-id"
      value={{@controller.categoryId}}
      {{on "input" (fn @controller.updateField "categoryId")}}
    />

    <label for="topic-title">New topic title</label>
    <input
      id="topic-title"
      value={{@controller.title}}
      {{on "input" (fn @controller.updateField "title")}}
    />

    <label for="topic-body">New topic body</label>
    <textarea
      id="topic-body"
      rows="16"
      value={{@controller.raw}}
      {{on "input" (fn @controller.updateField "raw")}}
    ></textarea>

    <button
      type="button"
      disabled={{@controller.busy}}
      {{on "click" @controller.previewPost}}
    >
      Preview
    </button>

    <button
      type="button"
      disabled={{@controller.busy}}
      {{on "click" @controller.publish}}
    >
      Publish topic
    </button>

    {{#if @controller.error}}
      <p class="alert alert-error">{{@controller.error}}</p>
    {{/if}}

    {{#if @controller.preview}}
      <h2>Preview</h2>
      <h3>{{@controller.preview.title}}</h3>
      <pre>{{@controller.preview.raw}}</pre>
    {{/if}}

    {{#if @controller.publishedUrl}}
      <p>
        Published:
        <a href={{@controller.publishedUrl}}>Open topic</a>
      </p>
    {{/if}}
  </div>
</template>

