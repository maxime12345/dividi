import Choices from "choices.js";

if ( document.querySelector("#no_model_fields_category") && document.querySelector("#no_model_fields_verbe")) {
  const choices_category = new Choices("#no_model_fields_category", {
    removeItems: true,
    removeItemButton: true,
  });

  new Choices("#no_model_fields_verbe", {
    removeItems: true,
    removeItemButton: true,
  });

  new Choices("#test", {
    removeItems: true,
    removeItemButton: true,
  });

  document.querySelectorAll('select.choices__input.is-hidden').forEach(function(element) {
    element.style.display='none';
  });
};

