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
      tmp_checkout = File.join(Dir.tmpdir, "reveal.js.#{Time.now.to_i}")
      `git clone git://github.com/hakimel/reveal.js.git #{tmp_checkout}`
      self.name = presentation_name.underscore
      directory(
        "template",
        name,
        date: Date.today,
        name: name
      )
      filetype_mappings = {css: "stylesheets", js: "javascripts"}
      %w(css js).each do |filetype|
        files = Dir[File.join("#{tmp_checkout}", filetype, "**", "*.#{filetype}")]
        files.each do |file|
          file_contents = File.read(file)
          file = file.gsub(File.join(tmp_checkout, filetype), '')
          create_file "#{name}/public/#{filetype_mappings[filetype.to_sym]}/#{file}", file_contents
        end
      end
      directory(File.join(tmp_checkout, 'plugin'), "#{name}/public/plugins")
      FileUtils.rmdir(tmp_checkout)
    end

    desc "present", "Start and open a presentation"
    def present
      `rackup config.ru && open http://localhost:9292`
    end
  end
end
