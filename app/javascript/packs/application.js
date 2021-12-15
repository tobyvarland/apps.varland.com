import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import "cocoon"
import "chartkick/chart.js"
import Chart from 'chart.js/auto';
import moment from 'moment'
window.moment = moment
window.Chart = Chart

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

// document.addEventListener("DOMContentLoaded", function(event) {
$(document).on('turbolinks:load', function() {

  // Auto refresh if necessary.
  var $body = $("body");
  var autoRefresh = $body.data("auto-refresh");
  if (autoRefresh > 0) {
    $("#auto_refresh").removeClass("d-none");
    $("#auto_refresh_remaining").data("remaining", autoRefresh).text(secondsToHumanReadable(autoRefresh));
    setTimeout(updateRemaining, 1000);
  }

  // Configure auto submitting forms.
  disableFormFieldsWaitingForSubmit();

  // Handle part spec links.
  handlePartSpecLinks();

  // Set up part search photos.
  showPartSearchPhotos();

  // Set up shop order links.
  setupShopOrderLinks();

});

function setupShopOrderLinks() {
  $(".shop_order_pdf_link").each(function() {
    var $link = $(this);
    var shopOrder = $link.data("shop-order");
    var url = "http://vcmsapi.varland.com/shop_order?shop_order=" + shopOrder;
    $.ajax(url).done(function(data) {
      if (data.valid) {
        var linkUrl = null;
        if (data.current) {
          linkUrl = "http://pdfapi.varland.com/so?shop_order=" + shopOrder;
        } else {
          linkUrl = "http://so.varland.com/so/" + shopOrder;
        }
        var $pdfLink = $("<a>");
        $pdfLink.attr("href", linkUrl).attr("target", "_blank").html("<i class=\"fas fa-file-pdf\"></i>").addClass("text-vp-red").addClass("small");
        $link.append($pdfLink);
      }
    });
  });
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

function disableFormFieldsWaitingForSubmit() {
  $(".all-auto-submit :input").on("change", function() {
    if ($(this).val() == "") return;
    var $form = $(this).closest('form');
    var $icon = $form.find('.loading-icon');
    $icon.removeClass("d-none");
    var $fields = $form.find('.form-fields');
    $fields.addClass("d-none");
    $form.trigger("submit");
  });
}

function handlePartSpecLinks() {

  $(".link-part-spec").on("click", function(event) {
    event.preventDefault();
    var $link = $(this);
    $.ajax($link.prop("href")).done(function(data) {
      $link.removeClass("text-muted").fadeOut(100, function() {
        $link.fadeIn(100, function() {
          $link.fadeOut(100, function() {
            $link.fadeIn(100, function() {
              $link.fadeOut(100, function() {
                $link.fadeIn(100, function() {
                  $link.addClass("text-muted");
                });
              });
            });
          });
        });
      });
    });
  })

}

function showPartSearchPhotos() {

  // Define possible extensions in order of likeliness.
  var extensions = ["jpg", "png"];
  var countExtensions = extensions.length;

  // Process each control number.
  $(".control-number-container").each(function() {
    var $controlNumberContainer = $(this);
    var controlNumber = parseInt($controlNumberContainer.text());
    if (controlNumber && controlNumber > 0) {
      var $partContainer = $controlNumberContainer.closest(".part-search-part");
      var $imageContainer = $partContainer.find(".part-search-image-container");
      for (var i = 0; i < countExtensions; i++) {
        var imageUrl = "http://so.varland.com/so_photos/" + controlNumber + "." + extensions[i];
        $.ajax(imageUrl)
          .done(function(data, textStatus, jqXHR) {
            if (jqXHR.status != 200) return;
            var $link = $("<a>");
            $link.attr("href", imageUrl).attr("target", "_blank");
            $link.addClass("part-search-image");
            var $image = $("<img>");
            $image.attr("src", imageUrl);
            $image.appendTo($link);
            $($image).on("error", function() {
              $link.addClass("d-none");
            });
            $link.appendTo($imageContainer);
          });
      }
    }
  });

}