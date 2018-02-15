import "./icon.css";
const feather = require('feather-icons');

document.addEventListener('turbolinks:load', function(){
  feather.replace();
});
