import { Controller } from "stimulus";
import "./rich_text_block.css";
import "quill/dist/quill.snow.css";
import Quill from "quill";

export default class extends Controller {
  connect() {
    let options = {
      placeholder: "Type something...",
      theme: "snow"
    };
    this.editor = new Quill(this.editorElement, options);
    this.editor.on("text-change", this.onTextChange.bind(this));
  }

  onTextChange(e) {
    this.inputElement.value = this.editor.root.innerHTML;
  }

  get editorElement() {
    return this.targets.find("editor");
  }

  get inputElement() {
    return this.targets.find("input");
  }
}
