import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import * as bootstrap from 'bootstrap'
import "../stylesheets/application"
import "@fortawesome/fontawesome-free/js/all"

document.addEventListener("DOMContentLoaded", function(event) {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
});