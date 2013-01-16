require "spec_helper"

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
        colorscheme :bar
        root File.expand_path(File.join('..', '..', 'fixtures'), File.dirname(__FILE__))
        theme :foo
      end
      rack_app.instance_variable_get(:@run).config.theme.should == :foo
    end
  end

  describe "a live app" do
    include Capybara::DSL

    before do
      Capybara.app = Revelation::Presentation.presentation do
        title "AwesomeSauce"
        theme :foo
        colorscheme :bar
      end
    end

    it "responds to the root URL with the presentation" do
      visit "/"
      page.status_code.should == 200
    end

    it "names the document after the title of the presentation" do
      visit "/"
      page.should have_css("head title", "AwesomeSauce")
      #first("title").native.text.should == "AwesomeSauce"
    end

    it "includes the correct theme stylesheet" do
      visit "/"
      first("link#theme")["href"].should == "/stylesheets/themes/foo.css"
    end

    it "returns 404 when it can't find a file" do
      visit "/foobar"
      page.status_code.should == 404
    end
  end
end
