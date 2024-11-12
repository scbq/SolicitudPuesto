import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Carga todos los controladores automáticamente
const context = require.context(".", true, /\.js$/);
context.keys().forEach((key) => {
  const controllerName = key.match(/\.\/(.*)_controller\.js$/)[1];
  application.register(controllerName, context(key).default);
});
