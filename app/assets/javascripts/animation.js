const change = document.querySelector('.section2');

window.addEventListener('scroll', () => {

  if (window.scrollY > 337) {

    change.classList.add('scroll');

  }

  else {

    change.classList.remove('scroll');
  }

});
