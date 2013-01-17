require 'rubygems'
require 'configurator'
require 'haml'
require 'rack'

module Revelation
  class Presentation
    include Configurator

    class << self
      def presentation(&block)
        app = new.tap do |presentation|
          presentation.config(&block) if block_given?
        end

        Rack::Builder.new do
          use Rack::Static,
            root: Revelation::Presentation.public_path.to_s,
            urls: Revelation::Presentation.public_urls
          run app
        end
      end

      def public_path
        @public_path ||= Revelation.root.join('public')
      end

      def public_urls
        @public_urls ||= begin
          # Build a list of static files
          public_urls = Dir[public_path.join('*')]
          public_urls = public_urls.select{|file| File.directory?(file) }
          public_urls.map{|file| file.gsub(public_path.to_s, '') }
        end
      end
    end

    def call(env)
      if env['REQUEST_URI'] == '/' || env['PATH_INFO'] == '/'
        [200, {'Content-Type' => 'text/html'}, [to_html]]
      else
        [404, {'Content-Type' => 'text/html'}, ["<h1>404 File Not Found</h1><p>Couldn't find whatever you were looking for, friend."]]
      end
    end

    def initialize
      option :author, "Flip Sasser"
      option :colorscheme, :zenburn
      option :theme, :default
      option :title, "Revelation Presentation"
    end

    def slides
      Dir[Revelation.root.join('slides', '**', '*.haml')]
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

    def slide(slide_path)
      slide_path = slide_path.to_s
      unless slide_path =~ /^\// || slide_path =~ /\.haml$/
        slide_path = Revelation.root.join('slides', "#{slide_path}.haml")
      end
      slide_id = File.basename(slide_path, File.extname(slide_path))
      Haml::Engine.new("%section##{slide_id}= partial(#{slide_path.to_s.inspect})").render(self)
    end
  end
end
