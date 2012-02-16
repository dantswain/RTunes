#!/usr/bin/ruby
require 'rbosa'
require 'optparse'

class RTunes
  def initialize
    @itunes = OSA.app('iTunes')
    @did_something = false
  end

  def volume_change amt
    puts "change amt: #{amt}"
    current_volume = @itunes.sound_volume
    @itunes.sound_volume = current_volume + amt 
    @did_something = true
  end

  def method_missing(meth, *args, &block)
    if @itunes.respond_to?(meth)
      @itunes.send(meth, *args, &block)
      @did_something = true
    else
      super
    end
  end

  def did_something?
    @did_something
  end
end

if __FILE__ == $0
  rtunes = RTunes.new

  optparse  = OptionParser.new do |opts|
    opts.banner = "rTunes Usage: "

    opts.on('-n', '--skip', 'Skip to the next track') do
      rtunes.next_track
    end

    opts.on('-r', '--previous', 'Previous track') do
      rtunes.previous_track
    end

    opts.on('-p', '--pause', 'Play/pause') do
      rtunes.playpause
    end

    opts.on('-d', '--volume-down [AMT]', OptionParser::DecimalInteger, 
            'Volume down by AMT (default 10)') do |amt|
      amt ||= 10
      rtunes.volume_change -amt
    end

  opts.on('-u', '--volume-up [AMT]', OptionParser::DecimalInteger, 
          'Volume up by AMT (default 10)') do |amt|
      amt ||= 10
      rtunes.volume_change amt
    end

  opts.on('-h', '--help', 'Display help') do
      puts opts
      exit
    end
  end

  begin
    optparse.parse!
  rescue
    $stderr.puts "Error: " + $!
    exit
  end

  $stderr.puts optparse unless rtunes.did_something?
end
