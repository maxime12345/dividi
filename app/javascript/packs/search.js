const form = document.querySelector('#filter-form');

if (form) {
  const inputs = document.querySelectorAll("input[type='checkbox']");
  inputs.forEach((div) => {
    div.addEventListener('click', () => {
      form.submit();
    });
  });
};
