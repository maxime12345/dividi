const change = document.querySelector('.section2');


if (change) {
  window.addEventListener('scroll', () => {

    if (window.scrollY > 337) {

      change.classList.add('scroll');

    }

    else {

      change.classList.remove('scroll');
    }

  });

  const foot = document.querySelector('.section3');

  window.addEventListener('scroll', () => {

    if (window.scrollY > 437) {

      foot.classList.add('scroll');

    }

    else {

      foot.classList.remove('scroll');
    }

  });
}

