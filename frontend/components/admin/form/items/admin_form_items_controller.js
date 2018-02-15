import 'babel-polyfill';
import "./items.css";
import A11yDialog from 'a11y-dialog';

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.pageWrapper = document.querySelector(".js-page-wrapper");
    this.modal = document.getElementById("admin-form-items-modal");

    this.modalContent = this.modal.querySelector(".js-admin-form-items-modal-content");
    this.closeButton = this.modal.querySelector(".js-admin-form-items-destroy");

    this.dialog = new A11yDialog(this.modal, this.pageWrapper);
    this.dialog.on('show', this.moveFormToModal.bind(this));
    this.dialog.on('hide', this.removeFormFromModal.bind(this));

    this.closeButton.addEventListener('click', this.onClickDestroy.bind(this));
  }

  // Move the form fields to the modal content
  moveFormToModal(dialogEl, event) {
    let form = event.target.nextElementSibling;
    if (form.classList.contains("js-admin-form-items-form")) {
      this.modalContent.appendChild(form);
      this.currentItem = event.target;
      this.currentForm = form;
    }
  }

  // Move the form fields back to where they were
  removeFormFromModal() {
    this.currentItem.parentNode.insertBefore(this.currentForm, this.currentItem.nextSibling);
    this.resetCurrent();
  }

  resetCurrent() {
    this.currentItem = null;
    this.currentForm = null;
  }

  onClickDestroy(e) {
    this.destroyCurrentItem();
  }

  destroyCurrentItem(toggle = true) {
    // TODO: finish this feature
    let destroyInput = this.currentForm.querySelector(".js-admin-form-items-destroy-field");
    destroyInput.value = toggle.toString();
    this.currentItem.classList.add("is-destroyed");
    this.dialog.hide();
    this.removeFormFromModal();
  }
}
