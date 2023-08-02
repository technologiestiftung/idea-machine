import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    port: {
      type: Number,
      default: 8000,
    },
    path: {
      type: String,
      default: "",
    },
    body: Object,
  };

  connect() {
    this.hasBodyValue && this.sendRequest();
  }

  sendRequest() {
    fetch(this.resource, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(this.bodyValue),
    });
  }

  get resource() {
    return `http://localhost:${this.portValue}${this.pathValue}`;
  }
}
