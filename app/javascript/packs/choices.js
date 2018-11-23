import Choices from "choices.js";

if ( document.querySelector("#category_search") ) {
  const choices_category = new Choices("#no_model_fields_category", {
    removeItems: true,
    removeItemButton: true,
  });

  new Choices("#category_search", {
    removeItems: true,
    removeItemButton: true,
  });

  new Choices("#verbe_search", {
    removeItems: true,
    removeItemButton: true,
  });

  // Need to hide first part
  document.querySelectorAll('select.choices__input.is-hidden').forEach(function(element) {
    element.style.display='none';
  });
};

