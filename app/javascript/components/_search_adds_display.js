const searchAddsDisplay = () => {
  const searchAdds = document.getElementById("search-adds");

  if (searchAdds) {
    const searchInput = document.querySelector(".sb-input").value;
    if (!searchInput) {
      searchAdds.classList.add("d-none");
    }
  }
};

export { searchAddsDisplay };
