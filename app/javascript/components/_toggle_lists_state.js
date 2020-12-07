const toggleListsState = () => {
  const listButtons = document.querySelectorAll("#action-buttons .button");
  if (listButtons) {
    listButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.currentTarget.classList.toggle('active');
      });
    });
  };
};

export { toggleListsState }
