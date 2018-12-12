import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    if (this.element.classList.contains("js-is-hidden")) {
      this.reveal();
      setTimeout(this.destroy.bind(this), 4000);
    }
  }

  close(event) {
    event.preventDefault();
    this.hide();
    setTimeout(this.destroy.bind(this), 500);
  }

  reveal() {
    this.element.classList.remove("js-is-hidden");
  }

  hide() {
    this.element.classList.add("js-is-closed");
  }

  destroy() {
    this.element.parentNode.removeChild(this.element);
  }
}
