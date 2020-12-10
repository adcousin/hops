const colorsFilter = () => {
  const colors = document.querySelectorAll(".tag-color");

  if (colors.length > 0) {
    colors.forEach((color) => {
      color.addEventListener("click", ()=> {
        // set active color
        if (color.classList.contains("active")) {
          color.classList.toggle("active");
        } else {
          colors.forEach((col) => {
           col.classList.remove("active");
          });
          color.classList.add("active");
        }

        // display full beers list
        const beers = document.querySelectorAll(".brew-beer");
        beers.forEach((beer) => {
          beer.classList.remove("d-none");
        });

        // if a color is selected, hide the other colors
        const activeColor = document.querySelector(".tag-color.active");
        if (activeColor) {
          const currentColor = activeColor.dataset.color;
          beers.forEach((beer) => {
            if (beer.dataset.color != currentColor) {
              beer.classList.add("d-none");
            }
          });
        }
      });
    });
  }
}

export { colorsFilter };
