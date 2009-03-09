#!/usr/bin/env ruby -W
idx = ENV['TM_LINE_INDEX'].to_i
char = ENV['TM_CURRENT_LINE']
puts idx == 0 || char[idx - 1, idx] != ':' ? ':' : ''