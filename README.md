# Revelation

Revelation provides you with a Rack-powered, HAML-based, Reveal.js presentation in a few simple steps.

## Installation

`gem install revelation`

## Usage

Installation adds a `revelation` command that behaves similarly to the `rails` command. To get started, do something like this:

`revelation new demo && cd demo`

`revelation present`

This will create and open a Reveal.js presentation from scratch. Pretty cool, right?

## Commands

## `new`

**Usage:** `revelation new PRESENTATION_NAME_HERE`

Creates a new presentation in its own folder.

## `present`

**Usage:** `revelation present`

Runs your presentation in your default browser, preferably at full-screen.

## `slide`

**Usage:** `revelation slide SLIDE_NAME`

Creates a new slide and inserts it into the presentation. Edit it by opening `slides/SLIDE_NAME.haml`.

## `compile`

**Usage:** `revelation compile`

Compiles your presentation into HTML, negating the need for a Rack server.

## Presentation organization

Once you've run `revelation new demo`, you can edit the `Demo` presentation. The presentation is organized like so:

- `config.ru` - the Rackup file used to run your presentation
- `presentation.rb` - the Ruby file used to configure your presentation's global settings
- `public/` - the folder containing your stylesheets and javascripts
	- `javascripts/` - the folder containing reveal.js and other supporting javscript source files
	- `images/` - the folder containing any images you want to use in your presentation
	- `stylesheets/` - the folder containing your stylesheets
- `slides/` - the folder containing your presentation slides
	- `introduction.haml` - the first slide in your presentation

## Slide helpers

You can use any ruby you want in the HAML slides, just 

## Why did I do this?

I dig Reveal.js, but thought it would be a lot nicer to use a simple, HAML-based DSL for editing my slides. So I built this and it works perfectly for me.