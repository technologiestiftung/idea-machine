import { Controller } from "@hotwired/stimulus";

/**
 * Controller to enhance HTML form elements with additional behaviour.
 * As of now we provide a submit method, that can be triggered e.g. through
 * keyboard actions such as keyboard events, see https://stimulus.hotwired.dev/reference/actions
 */
export default class extends Controller {
  submit() {
    this.element.requestSubmit();
  }
}
