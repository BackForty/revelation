require 'rubygems'
require 'configurator'
require 'haml'
require 'rack'
require 'tilt'

module Revelation
  class Presentation
    extend Configurator

    option :author, "Flip Sasser"
    option :colorscheme, :zenburn
    option :root, nil
    option :theme, :default
    option :title, "Revelation Presentation"

    attr_accessor :file_server

    class << self
      def present(&block)
        config(&block) if block_given?

        presentation = self

        Rack::Builder.new do
          use presentation
          run Rack::File.new(presentation.root.join('public'))
        end
      end

      def root
        config.root && Pathname.new(config.root) || Revelation.root
      end
    end

    def call(env)
      path = env['PATH_INFO'].to_s.gsub(/^\//, '')
      case path
      when ''
        respond('text/html', to_html)
      when 'config.js', 'presentation.js'
        respond(
          'application/javascript',
          File.read(root.join('config', path))
        )
      else
        @app.call(env)
      end
    rescue Errno::ENOENT
      @app.call(env)
    end

    def config
      self.class.config
    end

    def initialize(app)
      @app = app
    end

    def root
      self.class.root
    end

    def slides
      Dir[root.join('slides', '**', '*')]
    end

    def to_html
      Haml::Engine.new(layout).render(self)
    end

    private
    def layout
      File.read(File.join(File.dirname(__FILE__), 'layout.haml'))
    end

    def partial(path)
      unless path =~ /^\//
        path = root.join(path)
      end
      Tilt.new(path.to_s).render(self)
    end

    def respond(content_type, content)
      [200, {'Content-Type' => content_type}, Array(content)]
    end

    def slide(slide_path)
      slide_path = slide_path.to_s
      unless slide_path =~ /^\// || slide_path =~ /\.\w+$/
        slide_path = root.join('slides', slide_path)
        return "" unless slide_path = Dir["#{slide_path}.*"].first
      end
      slide_id = File.basename(slide_path, File.extname(slide_path))
      Haml::Engine.new("%section##{slide_id}= partial(#{slide_path.to_s.inspect})").render(self)
    end
  end
end
