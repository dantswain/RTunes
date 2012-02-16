RTunes
======

Dan Swain, dan.t.swain@gmail.com, 2/16/2012

RTunes is a thin wrapper for using [rbosa](http://rubyosa.rubyforge.org/)'s Ruby/Apple Event Manager bridge to control iTunes.  I wrote it to facilitate adding keyboard shortcuts to various editors/IDEs.

Requirements
------------

* Mac OS X*
* The 'rbosa' gem - `sudo gem install rbosa`
* Written and run with Ruby 1.8.7.  It should work on newer versions.

\* I'm not sure what versions of OS X will or won't work.  I run it on Snow Leopard and don't see why it wouldn't work on any version of OS X that has Ruby and Gem installed, but you never know.  Let me know if you have any success or failure :)

Usage
-----

#### rTunes.rb

Either make rTunes.rb executable (`chmod +x rTunes.rb`) or run it with Ruby (`ruby rTunes.rb`).

    rTunes Usage: 
        -n, --skip                       Skip to the next track
        -r, --previous                   Previous track
        -p, --pause                      Play/pause
        -d, --volume-down [AMT]          Volume down by AMT (default 10)
        -u, --volume-up [AMT]            Volume up by AMT (default 10)
        -h, --help                       Display help

#### RTunes class

For the most part, rTunes relies on `method_missing` to delegate function calls to an instance of `OSA.app('iTunes')`.  You can generate the documentation for that by running `rdoc-osa --name iTunes` - or look [here](http://rubyosa.rubyforge.org/itunes-doc/).  

The only two added functions at this point are `RTunes::volume_change` and `RTunes::did_something?`.  

* `RTunes::volume_change amt` changes the volume by `amt`.  The volume is a number from 0 to 100, so an `amt` of 10 is a 10% change.
* `RTunes::did_something?` returns true if you've actually used the object instance to do anything with iTunes.  (It's used in the script, and should really be refactored out of the `RTunes` class.)

A simple example:

    rtunes = RTunes.new
    # skip to the next song
    rtunes.next_track
    # decrease the volume 10%
    rtunes.volume_change -10
