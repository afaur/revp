require 'optparse'
require 'awesome_print'
require 'pry'

require_relative './review_range.rb'

options = {}

opt_parser = OptionParser.new do |opts|

  opts.banner = "Usage: ./revp [options]"
  opts.separator "Specific options:"

  opts.on("-s", "--start YEAR MON DAY HOUR MIN SEC", "When should we start generating processors") do |start|
    options[:start] = start
  end

  opts.on("-e", "--end YEAR MON DAY HOUR MIN SEC", "When should we stop generating processors") do |stop|
    options[:stop] = stop
  end

  opts.on("-p", "--phrase in two seconds", "How far apart should each increment be") do |phrase|
    options[:phrase] = phrase
  end

end

opt_parser.parse!(ARGV)

options[:start]   = options[:start]   || "2016 1 1 0 0 0"
options[:stop]    = options[:stop]    || "2016 1 1 2 0 0"
options[:phrase]  = options[:phrase]  || "in 2 seconds"

review_range = ReviewRange.new(
  start: options[:start].split(' '),
  stop: options[:stop].split(' '),
  increment_phrase: options[:phrase]
)

template = File.open('./config/template.txt', 'r')
command = template.read
template.close

if File.exist?('./output/script.sh')
  `rm ./output/script.sh`
end

review_range.next { |slice_begin, slice_end|
  open('./output/script.sh', 'a') { |f|
    f.puts command.gsub('$1',slice_begin).gsub('$2',slice_end).gsub('"','')
  }
}





























