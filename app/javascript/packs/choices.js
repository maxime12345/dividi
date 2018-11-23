import Choices from "choices.js";
import "choices.js/src/styles/choices.scss";

if (document.querySelector("#category_search")) {
  new Choices("#category_search", {
    removeItems: true,
    removeItemButton: true,
  });
};

if (document.querySelector("#verbe_search")) {
  new Choices("#verbe_search", {
    removeItems: true,
    removeItemButton: true,
  });
};
