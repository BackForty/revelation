require './lib/reveal'

run Rack::File.new(Reveal.root.join('public').to_s)
run Reveal::Presentation.new
