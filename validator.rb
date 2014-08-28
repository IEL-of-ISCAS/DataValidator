#!/usr/bin/env ruby
require 'descriptive-statistics'
require 'colorize'
require 'gnuplot'
require_relative './item.rb'

filePath = ARGV[0]

@time = []
@distance = []
@phase1Distance = []
@phase1Time     = []
@phase2Distance = []
@phase2Time     = []

imagePath = filePath.sub("txt", "png")

File.open(filePath, "r").each do |line|
	item = ActionItem.new line

	diffX = item.end1_x - item.start1_x
	diffY = item.end1_y - item.start1_y
	phase1Distance = Math.sqrt(diffX * diffX + diffY * diffY)

	diffX = item.end2_x - item.start2_x
	diffY = item.end2_y - item.start2_y
	phase2Distance = Math.sqrt(diffX * diffX + diffY * diffY)

	@time           << item.totalTime
	@distance       << phase1Distance + phase2Distance
	@phase1Time     << item.phase1Time
	@phase2Time     << item.phase2Time
	@phase1Distance << phase1Distance
	@phase2Distance << phase2Distance
end

puts "======================================="
puts "Stats for #{filePath}\n"

stats = DescriptiveStatistics::Stats.new(@time)
puts "- Total Time: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

stats = DescriptiveStatistics::Stats.new(@distance)
puts "- Total Distance: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

stats = DescriptiveStatistics::Stats.new(@phase1Time)
puts "- Phase1 Time: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

stats = DescriptiveStatistics::Stats.new(@phase1Distance)
puts "- Phase1 Distance: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

stats = DescriptiveStatistics::Stats.new(@phase2Time)
puts "- Phase2 Time: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

stats = DescriptiveStatistics::Stats.new(@phase2Distance)
puts "- Phase2 Distance: "
puts "    Mean: #{stats.mean}, SD: #{stats.standard_deviation} #{(stats.standard_deviation > 400 ? "[ FAILED ]".red : "[ PASSED ]".green)}"

puts "- Plotting Points: "
Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
   	plot.terminal "png"
    plot.output imagePath

    plot.title  "Time - Distance"
    plot.xlabel "Time"
    plot.ylabel "Distance"

    plot.data << Gnuplot::DataSet.new( [@time, @distance] ) do |ds|
      ds.with = "points"
      ds.notitle
    end
  end
end

puts "=======================================\n\n"