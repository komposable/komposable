import "./admin_heading.css";

import StickySidebar from 'sticky-sidebar';

document.addEventListener('turbolinks:load', function(){

  if (document.querySelectorAll('.has-sticky-heading').length == 0) return;

  var sidebar = new StickySidebar('.has-sticky-heading .admin-heading', {
    containerSelector: '.admin-form',
    innerWrapperSelector: '.admin-heading-content'
  });

});
