//hides the price field when launching JS

const item_price = document.querySelector('.item_price');
item_price.classList.add('hidden');

 //hides or display the price field according to the selected verb

const verb_check = document.querySelectorAll('.form-check');
const items_with_price = ['item_verbe_to_sell','item_verbe_to_rent'];
const items_without_price = ['item_verbe_to_give','item_verbe_to_lend'];

verb_check.forEach(function(element) {
  const input_check = element.firstChild;
  input_check.addEventListener('click', () => {
    if (items_with_price.includes(input_check.id)) {
      item_price.classList.remove('hidden');
    } else if (items_without_price.includes(element.firstChild.id)) {
      item_price.classList.add('hidden');
    }
  });
});
