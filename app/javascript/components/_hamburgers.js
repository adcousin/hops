const toggleHamburger = () => {
  const hamburger = document.querySelector('.hamburger');
  if (hamburger) {
      hamburger.addEventListener('click', (event) => {
        hamburger.classList.toggle('is-active')
        //selectBrewerySection.classList.toggle('d-none')
    });
  };
};

export { toggleHamburger }
