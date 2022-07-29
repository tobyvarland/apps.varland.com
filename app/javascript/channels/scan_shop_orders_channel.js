import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {

  if (document.getElementById("scan-shop-order-live-container")) {

    consumer.subscriptions.create("Scan::ShopOrdersChannel", {

      connected() { console.log("Connected & listening for scanned shop orders!"); },

      disconnected() { /* console.log("Disconnected!"); */ },

      received(data) {
        console.log("Received data!");
        var container = $("#scan-shop-order-live-container");
        // container.children().last().remove();
        var so = $(data.so);
        container.prepend(so);
        so.addClass("live-highlight");
      }

    });

  }

});