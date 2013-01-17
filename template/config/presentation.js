// Presentation logic goes in here

Reveal.addEventListener('somestate', function() {
  // TODO: Sprinkle magic
}, false);

Reveal.addEventListener('ready', function(event) {
  // event.currentSlide, event.indexh, event.indexv
});

Reveal.addEventListener('slidechanged', function(event) {
  // event.previousSlide, event.currentSlide, event.indexh, event.indexv
});
