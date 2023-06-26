import { Controller } from "@hotwired/stimulus";

/**
 * Controller that enhances the ideas form. When programmatically submitting the form,
 * we set a loading message. This is not an ideal implementation, but for now it's okay.
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
      timerInMilliseconds > 1000 || timerInMilliseconds < 10_000;

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

    ideaPlaceholderWrapper.classList.add("w-full");
    ideaPlaceholderWrapper.classList.add("text-gray-400");
    ideaPlaceholderWrapper.classList.add("text-center");

    const placeholderParagraph = idea.querySelector("p");
    placeholderParagraph.textContent = "Idee wird generiert ...";
  }
}
