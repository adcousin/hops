const focusSearchBar = () =>{
  const searchBar = document.getElementById('search-bar')
  if(searchBar){
    const searchInput = document.querySelector('.sb-input')
    searchInput.focus();
  }
}

export {focusSearchBar}