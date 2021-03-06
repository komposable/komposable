/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "admin";
import "components/admin";
import "components/blocks";

import Application from "stimulus_application";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import Rails from "rails-ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "activestorage";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

const context = require.context("../components/admin", true, /_controller\.js$/);
Application.load(definitionsFromContext(context));
const application = Application.start();
