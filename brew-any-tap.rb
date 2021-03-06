# brew-any-tap.rb
# Copy-pasta makes me sad. So let's require 'cmd/tap'.
require 'cmd/tap'
include Homebrew

usage = <<EOF
SYNOPSIS
    brew any-tap [-r|--repair] [-h|-?|--help] [name URL]

USAGE
    brew any-tap
      Called without arguments, any-tap will show your currently tapped
      repos.
    brew any-tap -h|-?|--help
      Called in any of these ways, any-tap will print this usage.
    brew any-tap -r|--repair
      Called with `-r` or `--repair`, any-tap will repair symlinks and prune
      any orphaned symlinks from all current taps.
    brew any-tap name URL
      Called this way, any-tap will attempt to clone any repository and tap
      (i.e. symlink) all of the formulae in that repository.

      In particular, any-tap will pass along the name and URL arguments to
      git in this form:

          git clone URL name

      This means that you can clone any repository, using any protocol that
      git can handle (http, git, ssh, filesystem clones).

      That's the good news. The bad news is that unlinke `brew tap`, any-tap
      does not do *any* special casing. It provides no short-cuts. If you
      want to tap something from GitHub and you choose to use any-tap, you
      must provide the full URL.

      Thus, the following are equivalent:

          brew tap user/repo
          brew any-tap user-repo https://github.com/user/homebrew-repo

      In such a case, `brew tap` seems obviously easier.

      The advantage of any-tap is that `brew tap` cannot do any of the
      following:

        + Tap repos without 'homebrew-' in their name
        + Tap repos that aren't on GitHub
        + Tap repos with hyphens (other than 'homebrew-') in their name
        + Tap repos using any protocol other than HTTP

EOF

def raw_install_tap(args)
  dir, url = args[0..1]
  # downcase to avoid case-insensitive filesystem problems
  tapd = validate_name(dir.downcase)

  safe_system('git', 'clone', url, tapd)
  files = []
  tapd.find_formula{ |file| files << tapd.basename.join(file) }
  link_tap_formula(files)
  puts "Tapped #{files.count} formula"
end

def validate_name(name)
  raise "No slashes in tap names." if name =~ %r{/}
  tapd = HOMEBREW_LIBRARY/"Taps/#{name}"
  if tapd.directory?
    raise "Choose another name: a tap #{name} already exists."
  end
  tapd
end

if ARGV.size < 1
  tapd = HOMEBREW_LIBRARY/"Taps"
  tapd.children.each do |tap|
    puts tap.basename.to_s if (tap/'.git').directory?
  end if tapd.directory?
elsif ['-h', '-?', '--help'].include?(ARGV.first)
  puts usage
elsif ['-r', '--repair'].include?(ARGV.first)
  repair_taps
else
  raw_install_tap(ARGV)
end
