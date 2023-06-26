import { Controller } from "@hotwired/stimulus";

/**
 * Controller that enhances the ideas form. When programmatically submitting the form,
 * we set a loading message. This is not an ideal implementation, but for now it's okay.
 * We also let the form auto-submit when a URL param for a timer is present.
 */
export default class extends Controller {
  static targets = ["input"];
  static values = { timer: { type: Number, default: -1 } };

  timerId() {
    return null;
  }

  inputTargetConnected() {
    if (this.timerId) {
      clearTimeout(this.timerId);
    }

    const timerInMilliseconds = this.timerValue * 1000;

    const isValidTimer =
      timerInMilliseconds > 1000 && timerInMilliseconds < 10_000;

    if (isValidTimer) {
      this.timerId = setTimeout(() => {
        this.submit();
      }, timerInMilliseconds);
    }
  }

  submit() {
    this.element.requestSubmit();
    this.showLoadingState();
  }

  showLoadingState() {
    const ideaPlaceholderWrapper = document.getElementById("idea");

    ideaPlaceholderWrapper.classList.add("text-center");
    ideaPlaceholderWrapper.classList.add("text-gray-900");

    const placeholderParagraph = idea.querySelector("p");
    placeholderParagraph.textContent = "Idee wird generiert ...";

    const spinner = document.getElementById("spinner");
    spinner.classList.remove("hidden");
    spinner.classList.add("block");
  }
}
