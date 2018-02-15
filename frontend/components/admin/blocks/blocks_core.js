import Sortable from "sortablejs";
import feather from "feather-icons";

let BlockForm = class {
  constructor(template, itemsCount) {
    return this.createElement(template, itemsCount);
  }

  createElement = function(template, index) {
    let element = document.createElement("div");
    let html = template.innerHTML;
    html = html.replace(/\[__.+?__\]/g, "[" + index + "]");
    html = html.replace(/___NEW__.+?___/g, "_" + index + "_");
    element.classList += "js-blocks-item";
    element.innerHTML = html;
    return element;
  };
};

export default class Blocks {
  constructor(HTMLElement) {
    this.wrapper = HTMLElement;

    if (!this.wrapper) return;

    this.initializeClickListeners();
    this.initializeSortable();

    document.addEventListener(
      "blocks:add",
      e => {
        this.updateBlockPositions();
        feather.replace();
      },
      false
    );

    document.addEventListener(
      "blocks:update",
      e => {
        this.updateBlockPositions();
      },
      false
    );

    return this.wrapper;
  }

  updateBlockPositions = () => {
    let items = this.wrapper.querySelectorAll(".js-blocks-item");
    for (let i = 0; i < items.length; i++) {
      let item = items[i];
      let positionInput = item.querySelector(".js-blocks-position");
      positionInput.value = i;
    }
  };

  initializeClickListeners = () => {
    this.wrapper.addEventListener("click", e => {
      if (!e.target) {
        return;
      }

      // Clicked on "Toggle" button
      if (e.target.classList.contains("js-blocks-buttons-toggle")) {
        this.openButtonsModal(e.target);
      }

      // Clicked on "Close" button
      if (e.target.classList.contains("js-blocks-buttons-close")) {
        this.closeButtonsModal(e.target);
      }

      // Clicked on "Add" button
      if (e.target.classList.contains("js-blocks-button-add")) {
        this.closeButtonsModal(e.target);

        let list = this.wrapper.querySelector(".js-blocks-list");
        let items = list.querySelectorAll(".js-blocks-item");
        let template = document.querySelector(`#${e.target.dataset.block}`);
        let form = new BlockForm(template, items.length);

        list.insertBefore(form, e.target.closest(".js-blocks-item"));

        let addEvent = new CustomEvent("blocks:add", {
          detail: { block: form }
        });
        document.dispatchEvent(addEvent);
      }

      // Clicked on "Destroy" button
      if (e.target.classList.contains("js-blocks-destroy")) {
        this.destroyItem(e.target);
      }

      // Clicked on "Undestroy" button
      if (e.target.classList.contains("js-blocks-undestroy")) {
        this.destroyItem(e.target, false);
      }
    });
  };

  openButtonsModal = el => {
    el.style.display = "none";
    let nextEl = el.nextElementSibling;
    if (nextEl.classList.contains("js-blocks-buttons-items")) {
      nextEl.classList.toggle("is-visible");
    }
  };

  closeButtonsModal = el => {
    let modalEl = el.closest(".js-blocks-buttons-items");
    let prevEl = modalEl.previousElementSibling;
    if (prevEl.classList.contains("js-blocks-buttons-toggle")) {
      prevEl.style.display = "";
    }
    modalEl.classList.toggle("is-visible");
  };

  destroyItem = (el, toggle = true) => {
    let itemEl = el.closest(".js-blocks-item");
    itemEl.classList.toggle("is-destroyed", toggle);
    let destroyInput = itemEl.querySelector(".js-blocks-destroy-field");
    destroyInput.value = toggle.toString();
  };

  initializeSortable = () => {
    let list = this.wrapper.querySelector(".js-blocks-list");

    let options = {
      sort: true,
      draggable: ".js-blocks-item",
      ghostClass: "is-ghost",
      handle: ".js-blocks-handle",
      onUpdate: event => {
        let updateEvent = new Event("blocks:update");
        document.dispatchEvent(updateEvent);
      },
      filter: ".js-blocks-up, .js-blocks-down",
      onFilter: function(e, ctrl) {
        var item = e.item,
          elem = item.previousElementSibling;

        if (Sortable.utils.is(e.target, ".move-down")) {
          elem = item.nextElementSibling.nextElementSibling;
        }

        this.el.insertBefore(item, elem);
      }
    };

    new Sortable(list, options);
  };
}
