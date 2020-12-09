

const goToTabWithAnchor = () => {
  const model = window.location.pathname.substring(1)
  const anchor = window.location.hash.substring(1)
  const element = document.getElementById(`${anchor}-tab`)
  if (element) {
    element.click()
  };
};

export { goToTabWithAnchor };
