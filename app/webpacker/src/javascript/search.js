const form = document.querySelector('#filter-form');


if (form) {
  console.log('jb');
  form.addEventListener('change', function() {console.log('changed')});
  form.addEventListener('change', function() { form.submit() });
}
