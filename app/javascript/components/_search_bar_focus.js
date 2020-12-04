const focusSearchBar = () =>{
  const searchBar = document.querySelector('.searchbar')
  if(searchBar){
    searchBar.focus();
  }
}

export {focusSearchBar}