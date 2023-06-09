import { Controller } from "@hotwired/stimulus";
import { enter } from "el-transition";

/**
 * This controller animates an element in once connected to the DOM.
 * See https://github.com/mmccall10/el-transition for configuration options.
 */
export default class extends Controller {
  connect() {
    this.element.classList.remove("hidden");
    enter(this.element);
  }
}
