const scrollIndicators = () => {
  const bsCards = document.querySelector(".bs-cards");

  if (bsCards) {
    bsCards.addEventListener("scroll", () => {
      const divWidth = bsCards.offsetWidth;
      const divScrollWidth = bsCards.scrollWidth;
      const divScrollLeft = bsCards.scrollLeft;

      const leftArrow = document.querySelector(".left-arrow");
      const rightArrow = document.querySelector(".right-arrow");

      if (divScrollLeft == 0) {
        leftArrow.classList.add("d-none");
      } else if (divScrollLeft + divWidth == divScrollWidth) {
        rightArrow.classList.add("d-none");
      } else {
        if (leftArrow.classList.contains("d-none")) {
          leftArrow.classList.remove("d-none");
        }
        if (rightArrow.classList.contains("d-none")) {
          rightArrow.classList.remove("d-none");
        }
      }
    });
  }
};

export { scrollIndicators };
