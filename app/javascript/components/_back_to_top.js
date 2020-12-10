import { event } from "jquery";

//Get the button:
const mybutton = document.getElementById("myBtn");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  const mybutton = document.getElementById("myBtn");
  if (mybutton){
    if (window.scrollY > window.innerHeight) {
      mybutton.style.display = "block";
    } else {
      mybutton.style.display = "none";
    }
  }
}

// When the user clicks on the button, scroll to the top of the document
if(mybutton){
  mybutton.addEventListener('click',(event) =>{
      document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
  })
}

export {scrollFunction}