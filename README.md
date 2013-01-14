# Reveal.js-on-Ruby

This gem provides you with shortcuts to generating a Sinatra-backed, HAML-powered Reveal.js presentation in a few simple steps.

## Installation

`gem install reveal.js`

## Usage

Installation adds a `reveal` command that behaves similarly to the `rails` command. To get started, do something like this:

`reveal new demo && cd demo`

`reveal present`

This will open a reveal.js presentation from scratch. Pretty cool, right?

## Commands

## `new`

**Usage:** `reveal new PRESENTATION_NAME_HERE`

This will create a new presentation in its own folder.

## `present`

**Usage:** `reveal present`

Runs your presentation in your default browser, preferably at full-screen.

## Presentation organization

Once you've run `reveal new demo`, you can edit the `Demo` presentation. The presentation is organized like so:

- `config.ru` - the Rackup file used to run your presentation
- `slides/` - the folder containing your presentation slides
- `public/` - the folder containing your stylesheets and javascripts
	- `javascripts` - the folder containing reveal.js and other supporting javscript source files
	- `images` - the folder containing any images you want to use in your presentation
	- `stylesheets` - the folder containing your stylesheets
