import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {

  if (document.getElementById("groov-live-logs-container")) {

    consumer.subscriptions.create("Groov::LogsChannel", {

      connected() { /* console.log("Connected!"); */ },

      disconnected() { /* console.log("Disconnected!"); */ },

      received(data) {
        var container = $("#groov-live-logs-container");
        var targetController = container.data("controller");
        if (!targetController || targetController == "" || targetController == data.controller) {
					container.children().last().remove();
					var log = $(data.log);
					container.prepend(log);
					log.addClass("live-highlight");
				}
      }

    });

  }

});