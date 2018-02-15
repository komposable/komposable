import application from "stimulus_application";
import { definitionsFromContext } from "stimulus/webpack-helpers";
const controllers = require.context("./", true, /_controller\.js$/);
application.load(definitionsFromContext(context));
