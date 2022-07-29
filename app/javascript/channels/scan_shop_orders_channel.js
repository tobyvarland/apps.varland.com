import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {

  if (document.getElementById("scan-shop-order-live-container")) {

    consumer.subscriptions.create("Scan::ShopOrdersChannel", {

      connected() { /* console.log("Connected & listening for scanned shop orders!"); */ },

      disconnected() { /* console.log("Disconnected!"); */ },

      received(data) {
        var container = $("#scan-shop-order-live-container");
        var so = $(data.so);
        container.prepend(so);
        $("#today-count").text(container.children().length);
        so.addClass("live-highlight");
        $("#today-count").addClass("live-highlight");
      }

    });

  }

});