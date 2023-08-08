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
    token: String,
    body: Object,
  };

  connect() {
    this.sendRequest();
  }

  sendRequest() {
    fetch(this.resource, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${this.tokenValue}`,
      },
      body: this.hasBodyValue ? JSON.stringify(this.bodyValue) : null,
    });
  }

  get resource() {
    return `http://localhost:${this.portValue}${this.pathValue}`;
  }
}
