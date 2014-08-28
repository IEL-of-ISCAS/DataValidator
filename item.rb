#!/usr/bin/env ruby

# EntityClass
class ActionItem
	attr_accessor :tar_x, :tar_y, :start1_x, :start1_y, :end1_x, :end1_y, :start2_x, :start2_y, :end2_x, :end2_y
	attr_accessor :phase1Time, :switchTime, :phase2Time, :totalTime

	def initialize content
		@tar_x, @tar_y, @start1_x, @start1_y, @end1_x, @end1_y, @start2_x, @start2_y, @end2_x, @end2_y, @phase1Time, @switchTime, @phase2Time = content.split("\t")
		@tar_x       = @tar_x.to_f
		@tar_y       = @tar_y.to_f
		@start1_x    = @start1_x.to_f
		@start1_y    = @start1_y.to_f
		@end1_x      = @end1_x.to_f
		@end1_y      = @end1_y.to_f
		@start2_x    = @start2_x.to_f
		@start2_y    = @start2_y.to_f
		@end2_x      = @end2_x.to_f
		@end2_y      = @end2_y.to_f
		@phase1Time  = @phase1Time.to_f
		@switchTime  = @switchTime.to_f
		@phase2Time  = @phase2Time.to_f
		@totalTime   = @phase1Time + @phase2Time
	end
end