const searchAddsDisplay = () => {
  const searchAdds = document.getElementById("search-adds");

  if (searchAdds) {
    const searchInput = document.querySelector(".sb-input").value;
    if (searchInput) {
      searchAdds.classList.remove("d-none");
    }
  }
};

export { searchAddsDisplay };
