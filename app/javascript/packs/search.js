const form = document.querySelector('#filter-form');

if (form) {
  document.querySelector('#filter-form').addEventListener('change', () => {
    form.submit();
  });
};
