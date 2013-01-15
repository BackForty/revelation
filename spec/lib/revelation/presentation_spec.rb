require 'spec_helper'

describe Revelation::Presentation do
  let(:presentation) { described_class.new }

  describe "defaults" do
    it "uses the theme ':default'" do
      presentation.config.theme.should == :default
    end

    it "uses the colorscheme ':zenburn'" do
      presentation.config.colorscheme.should == :zenburn
    end
  end

  it "accepts a configuration block" do
    presentation.config do
      theme :foo
      colorscheme :bar
    end
    presentation.config.theme.should == :foo
    presentation.config.colorscheme.should == :bar
  end

  describe ".presentation method" do
    it "accepts a block that executes the configuration" do
      rack_app = described_class.presentation do
        theme :foo
        colorscheme :bar
      end
      rack_app.instance_variable_get(:@run).config.theme.should == :foo
    end
  end

  describe "a live app" do
    include Rack::Test::Methods

    before { get '/' }

    def find(selector)
      html.css(selector)
    end

    def first(selector)
     find(selector).first
    end


    let :app do
      Revelation::Presentation.presentation do
        title "AwesomeSauce"
        theme :foo
        colorscheme :bar
      end
    end

    let(:html) { Nokogiri::HTML.parse last_response.body }

    it "responds to the root URL with the presentation" do
      last_response.should be_ok
    end

    it "names the document after the title of the presentation" do
      first('head title').content.should == "AwesomeSauce"
    end

    it "includes the correct theme stylesheet" do
      first('link#theme')['href'].should == "/stylesheets/themes/foo.css"
    end
  end
end
