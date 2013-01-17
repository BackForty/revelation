require "spec_helper"

describe Revelation::Presentation do
  let(:presentation) { described_class }

  describe "defaults" do
    it "uses the theme ':default'" do
      presentation.config.theme.should == :default
    end

    it "uses the colorscheme ':zenburn'" do
      presentation.config.colorscheme.should == :zenburn
    end
  end

  describe "a live app" do
    include Capybara::DSL

    before do
      Capybara.app = Revelation::Presentation.present do
        colorscheme :bar
        root File.expand_path(File.join('..', '..', 'fixtures'), File.dirname(__FILE__))
        theme :foo
        title "AwesomeSauce"
      end
    end

    it "responds to the root URL with the presentation" do
      visit "/"
      page.status_code.should == 200
    end

    it "names the document after the title of the presentation" do
      visit "/"
      page.should have_css("head title", "AwesomeSauce")
      first("title").native.text.should == "AwesomeSauce"
    end

    it "includes the correct theme stylesheet" do
      visit "/"
      first("link#theme")["href"].should == "/stylesheets/themes/foo.css"
    end

    it "returns 404 when it can't find a file" do
      visit "/foobar"
      page.status_code.should == 404
    end

    it "serves static files in the public folder" do
      visit "/javascripts/reveal.min.js"
      page.status_code.should == 200
    end

    %w(config.js presentation.js presentation.css).each do |file|
      it "knows about #{file}" do
        file_contents = File.read(Revelation.root.join('template', 'config', file))
        visit "/#{file}"
        page.body.should == file_contents
      end
    end
  end
end
