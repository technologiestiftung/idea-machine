import { Controller } from "@hotwired/stimulus";

/**
 * Controller that enhances the ideas form. When programmatically submitting the form,
 * we set a loading message. This is not an ideal implementation, but for now it's okay.
 */
export default class extends Controller {
  submit() {
    this.element.requestSubmit();

    const placeholder = document.getElementById("idea").querySelector("p");
    placeholder.textContent = "Idee wird generiert ...";
  }
}
