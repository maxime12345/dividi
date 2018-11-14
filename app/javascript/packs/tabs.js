const params_tab = new URL(location.href).searchParams.get("tab");

console.log(typeof params_tab === 'string');

console.log(params_tab  + 'li');

if ( typeof params_tab === 'string' ) {
  const li = document.getElementById(params_tab + '-li');
  const tab = document.getElementById(params_tab);
  const ul = document.querySelector('ul.nav.nav-tabs > li.active').classList ;
  const div = document.querySelectorAll('div.tab-content > div.active')[0].classList ;

  ul.remove('active');
  div.remove('in', 'active');
  li.classList.add('active');
  tab.classList.add('in', 'active');
};
