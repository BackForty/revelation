require 'pathname'

module Reveal
  autoload :Command, 'reveal/command'
  autoload :Presentation, 'reveal/presentation'

  def self.root
    @root ||= Pathname.new(Dir.pwd)
  end
end

# Add reveal to the load path
$LOAD_PATH.push Reveal.root.join('lib').to_s
$LOAD_PATH.push Reveal.root.join('config').to_s

# Prepare and load Bundler and its fun bundled gems y'all
ENV['BUNDLE_GEMFILE'] ||= Reveal.root.join('Gemfile').to_s
ENV['RACK_ENV'] ||= ENV['RAILS_ENV'] ||= 'development'

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

