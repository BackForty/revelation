require 'thor'

module Revelation
  class Command < Thor
    include Thor::Actions

    attr_accessor :author, :name, :title

    source_root File.expand_path('../..', File.dirname(__FILE__))

    desc "new PRESENTATION_NAME", "Creates a new presentation"
    def new(presentation_name)
      self.name = presentation_name.underscore
      directory(
        "template",
        name,
        date: Date.today,
        name: name
      )
    end
  end
end
