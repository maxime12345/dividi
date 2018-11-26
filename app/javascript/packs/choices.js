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

if (document.querySelector("#state_search")) {
  new Choices("#state_search", {
    removeItems: true,
    removeItemButton: true,
  });
};

if (document.querySelector("#request_search")) {
  new Choices("#request_search", {
    removeItems: true,
    removeItemButton: true,
  });
};
