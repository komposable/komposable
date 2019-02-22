import { Controller } from "stimulus";
import Turbolinks from "turbolinks";

export default class extends Controller {
  connect() {}

  clickBody(e) {
    if (
      e.target.classList.contains("admin-button") ||
      e.target.tagName === "A" ||
      e.target.closest("a, .admin-button")
    )
      return;
    e.preventDefault();

    const line = e.target.closest("tr");
    const defaultButton = line.querySelector(".admin-button.is-default-action");

    if (!defaultButton) return;
    Turbolinks.visit(defaultButton.href);
  }
}
