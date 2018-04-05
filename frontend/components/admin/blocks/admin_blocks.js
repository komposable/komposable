import "./admin_blocks.css";

import Blocks from './blocks_core';

document.addEventListener("turbolinks:load", () => {
  let blocks = new Blocks(document.querySelector(".js-blocks-component"));

  document.addEventListener("blocks:add", function(e) {
    console.log("Dispatch: blocks:add");
    console.log(e.detail.block);
  }, false);

  document.addEventListener("blocks:update", function(e) {
    console.log("Dispatch: blocks:update");
  }, false);

  document.addEventListener("blocks:destroy", function(e) {
    console.log("Dispatch: block:remove");
  }, false);
});
