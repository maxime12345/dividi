const alert = document.querySelector('.alert');

if (alert) {
  setTimeout(function(){ alert.classList.add('alert-hidden'); }, 3000);
}
