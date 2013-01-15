require 'fileutils'
require 'open-uri'
require 'thor'
require 'tempfile'

module Revelation
  class Command < Thor
    include Thor::Actions

    attr_accessor :author, :name, :title

    source_root File.expand_path('../..', File.dirname(__FILE__))

    desc "new PRESENTATION_NAME", "Creates a new presentation"
    def new(presentation_name)
      # Set the name up and create the dummy directory
      self.name = presentation_name.underscore
      directory("template", name, date: Date.today, name: name)
    end

    desc "present", "Start and open a presentation"
    method_option :port, :aliases => ['-p'], :default => 9292, :type => :numeric
    def present
      fork do
        begin
          `rackup config.ru -p #{options[:port]}`
        rescue SystemExit, Interrupt
        end
      end
      sleep 1
      `open http://localhost:#{options[:port]}`
      Process.wait
    rescue SystemExit, Interrupt
      warn "\nEnding presentation..."
      exit 1
    end

    desc "slide SLIDE_NAME", "Add a slide to your deck"
    def slide(slide_name)
      create_file "slides/#{slide_name.underscore}.haml"
      append_file "slides.haml", "= slide :#{slide_name.underscore}"
    end
  end
end
