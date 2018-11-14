if (window.location.href.includes('collections')) {

  const item_price = document.querySelector('.item_price');
  const item_verbe_to_lend = document.getElementById('item_verbe_to_lend');
  const item_verbe_to_give = document.getElementById('item_verbe_to_give');
  const verb_check = document.querySelectorAll('.form-check');
  const label_price = item_price.firstChild.innerText;
  const sell_label_price = label_price.split(" ").splice(0,3);


  //hides or display the price field when the page is loaded
  window.addEventListener('load', () => {
    toggleHiddenClass();
  });

  //hides or display the price field according to the selected verb
  verb_check.forEach(function(element) {
    const input_check = element.firstChild;
    input_check.addEventListener('click', () => {
      toggleHiddenClass();
    });
  });

  function toggleHiddenClass() {
    if (item_verbe_to_sell.checked === true) {
      item_price.firstChild.innerText = sell_label_price.join(" ");
      item_price.classList.remove('hidden');
    } else if (item_verbe_to_rent.checked === true) {
      item_price.firstChild.innerText = label_price;
      item_price.classList.remove('hidden');
    } else {
      item_price.classList.add('hidden')
    };
  };
};
