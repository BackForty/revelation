# Add revelation to the load path
$LOAD_PATH.push File.dirname(__FILE__)

require 'active_support/all'
require 'pathname'

module Revelation
  autoload :Command, 'revelation/command'
  autoload :Presentation, 'revelation/presentation'

  def self.root
    @root ||= Pathname.new(Dir.pwd)
  end
end
