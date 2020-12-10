const toggleBrewerySection = () => {
  const toggleButton = document.querySelector('.toggle.btn');
  if (toggleButton) {
    const addBrewerySection = document.querySelector('.add-brewery-beer');
    const selectBrewerySection = document.querySelector('.select-brewery');
      toggleButton.addEventListener('click', (event) => {
        addBrewerySection.classList.toggle('d-none')
        //selectBrewerySection.classList.toggle('d-none')
    });
  };
};

export { toggleBrewerySection }
