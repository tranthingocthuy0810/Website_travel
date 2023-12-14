/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// app/javastript/packs/application.js
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"

document.addEventListener("DOMContentLoaded", function() {
  const form = document.querySelector("form[data-target='checkout.form']");

  if (form) {
    form.addEventListener("submit", function(event) {
      event.preventDefault();

      fetch(form.action, {
        method: form.method,
        body: new FormData(form),
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          var stripe = Stripe("<%= Rails.application.credentials[:stripe][:public] %>");
          stripe.redirectToCheckout({
            sessionId: data.session_id
          }).then(function(result) {
            if (result.error) {
              console.error(result.error.message);
            }
          });
        } else {
          console.error(data.error_message);
        }
      });
    });
  }
});
