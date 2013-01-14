require 'haml'

module Revelation
  class Presentation
    def author
      "Flip Sasser"
    end

    def call(env)
      [200, {'Content-Type' => 'text/html'}, [to_html]]
    end

    def slides
      Dir[Revelation.root.join('slides', '**', '*.haml')]
    end

    def title
      "Revelation Presentation"
    end

    def to_html
      Haml::Engine.new(layout).render(self)
    end

    private
    def layout
      File.read(File.join(File.dirname(__FILE__), 'layout.haml'))
    end

    def partial(path)
      Haml::Engine.new(File.read(path)).render(self)
    end

    def sections
      slides.map {|slide| Haml::Engine.new("%section= partial(#{slide.inspect})").render(self) }.join("\n")
    end
  end
end
