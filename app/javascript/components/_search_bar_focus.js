const focusSearchBar = () =>{
  const searchBar = document.getElementById('search-bar')
  if(searchBar){
    const searchInput = document.querySelector('.sb-input')
    const len = searchInput.value.length;
    searchInput.focus();
    searchInput.setSelectionRange(len, len);
  }
}

export {focusSearchBar}