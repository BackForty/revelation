// Full list of configuration options available here:
// https://github.com/hakimel/reveal.js#configuration
Reveal.initialize({
  controls: true,
  progress: true,
  history: true,
  center: true,
  theme: Reveal.getQueryHash().theme,
  transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/none

  // Optional libraries used to extend on reveal.js
  dependencies: [
    // Cross-browser shim that fully implements classList - https://github.com/eligrey/classList.js/
    { src: '/javascripts/classList.js', condition: function() { return !document.body.classList; } },

    // Interpret Markdown in <section> elements
    { src: '/javascripts/plugins/markdown/showdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
    { src: '/javascripts/plugins/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },

    // Syntax highlight for <code> elements
    { src: '/javascripts/plugins/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },

    // Zoom in and out with Alt+click
    { src: '/javascripts/plugins/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },

    // Speaker notes
    { src: '/javascripts/plugins/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } },

    // Remote control your reveal.js presentation using a touch device
    { src: '/javascripts/plugins/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
  ]
});
