import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "cocoon"

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
  });

  /*
  $('.table-responsive').on('show.bs.dropdown', function () {
    $('.table-responsive').css( "overflow", "inherit" );
  });
  $('.table-responsive').on('hide.bs.dropdown', function () {
      $('.table-responsive').css( "overflow", "auto" );
  });
  */

});

$(function() {
  
  // Auto refresh if necessary.
  var $body = $("body");
  var autoRefresh = $body.data("auto-refresh");
  if (autoRefresh > 0) {
    $("#auto_refresh").removeClass("d-none");
    $("#auto_refresh_remaining").data("remaining", autoRefresh).text(secondsToHumanReadable(autoRefresh));
    setTimeout(updateRemaining, 1000);
  }

  // Set up clipboard links if necessary.
  $("[data-clipboard]").on("click", function(event) {
    event.preventDefault();
    var $element = $(this);
    var clipboardText = $element.data('clipboard');
    var result = copyTextToClipboard(clipboardText);
    console.log(result);
    if (result) {
      $element.addClass("highlight-fade-3s");
    }
  });

});

function fallbackCopyTextToClipboard(text) {
  var textArea = document.createElement("textarea");
  textArea.value = text;
  textArea.style.top = "0";
  textArea.style.left = "0";
  textArea.style.position = "fixed";
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();
  try {
    var successful = document.execCommand('copy');
    if (!successful) {
      alert("Failed to copy text to clipboard. Please contact IT.");
      return false;
    }
  } catch (err) {
    alert("Failed to copy text to clipboard. Please contact IT.");
    return false;
  }
  document.body.removeChild(textArea);
  return true;
}

function copyTextToClipboard(text) {
  return fallbackCopyTextToClipboard(text);
  /*
  if (!navigator.clipboard) {
    fallbackCopyTextToClipboard(text);
    return;
  }
  navigator.clipboard.writeText(text).then(function() {
    // Don't do anything.
  }, function(err) {
    alert("Failed to copy text to clipboard. Please contact IT.");
  });
  */
}

function secondsToHumanReadable(seconds) {
  var minutes = Math.floor(seconds / 60);
  var remainingSeconds = seconds - 60 * minutes;
  return minutes.toString() + ":" + (remainingSeconds < 10 ? "0" : "") + remainingSeconds.toString();
}

function updateRemaining() {
  var $container = $("#auto_refresh_remaining");
  var remaining = parseInt($container.data("remaining")) - 1;
  if (remaining == 0) {
    window.location.reload(true);
  } else {
    $container.data("remaining", remaining).text(secondsToHumanReadable(remaining));
    setTimeout(updateRemaining, 1000);
  }
}