// En fonction du rate, changer la class de l'icône
const toggleStarsInBlack = (rate) => {
  for (let index = 1; index <= 5; index++) {
    const star = document.getElementById(index);
    if (index <= rate) {
      star.className = "review-rate fas fa-beer"
    } else {
      star.className = "review-rate fas fa-beer inactive"
    }
  }
};

// Récupérer la valeur de rate
const updateRatingInput = (rate) => {
  const formInput = document.getElementById('review_rate')
  formInput.value = rate
}

// Fonction qui utilise les deux fonctions du dessus
const dynamicRating = () => {
  // Récupérer les icônes
  const stars = document.querySelectorAll('.review-rate');
  if ( stars.length > 0) {
    stars.forEach((star) => {
      // On utilise l'id des icônes pour mettre à jour le rate au clic avec les classes
      star.addEventListener("click", (event) => {
        const rate = event.currentTarget.id
        updateRatingInput(rate);
        toggleStarsInBlack(rate);
        star.classList.add("selected")
      });
      star.addEventListener("mouseover", (event) => {
        // Si absence de classe selected au survol, on anime
        const rate = event.currentTarget.id
        if (!(document.querySelector(".selected"))) {
          toggleStarsInBlack(rate);
        }
      });
    });
  };
};

export { dynamicRating };
