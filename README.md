# any-tap.rb: This one `brew tap`s anything you throw at it.

## WARNING ##

**This is alpha software. Use it at your own risk. It is very alpha.**

## What is it?

It's an [external command][ec] for [Homebrew][brew]. It is meant to be
a replacement for the built-in [`brew tap`][bt] command. That command has
certain limitations, but because of backwards compatibility, it's hard to
update.

This command scratches my itch. I wanted a souped-up version of `brew tap`.
I have freely borrowed (ahem, stolen) code from the existing `brew tap`
command. I thank all the people who worked on that.

[ec]: https://github.com/mxcl/homebrew/wiki/External-Commands
[brew]: https://github.com/mxcl/homebrew
[bt]: https://github.com/mxcl/homebrew/wiki/brew-tap

## Installation

+ The easiest thing is (ironically?) to use `brew tap`:

        brew tap telemachus/anytap
        brew install brew-any-tap

  That will install `brew any-tap` and `brew any-untap`. See below for
  brief usage notes on both.
+ If you prefer, however, you can simply clone this repository and then
  copy `brew-any-tap.rb` and `brew-any-untap.rb` anywhere in your `$PATH`.

  If you do that, `brew` will automatically be able to pick up the commands
  and do the right thing with them.

## Usage

+ `brew any-tap`
    + `brew any-tap -h|-?|--help`: Get usage
    + `brew any-tap`: List currently installed taps
    + `brew any-tap name URL`: Tap the repo at URL as 'name'
+ `brew any-untap`
    + `brew any-untap -h|-?|--help`: Get usage
    + `brew any-untap`: List currently installed taps
    + `brew any-untap name1 [name2 name3 ...]`: Untap one or more taps
+ The key difference between `brew tap` and `brew any-tap` is that `brew
  any-tap` will attempt to tap *any* URL that you give it. You can tap
  private repositories, things not on GitHub and things that have any
  naming conventions.

  The price you pay is that you must be more explicit. There's no
  special-casing for GitHub. You always must provide the full URL of what
  you want to tap. You always must provide the name you want the tap to
  have on disc. `brew any-tap` will simply hand over these arguments and
  try to run this command:

        git clone URL name

## Contributors

### TODO Fill in contributors to the original `brew tap`?

## Contributing

### TODO Put some contribution guidelines here
