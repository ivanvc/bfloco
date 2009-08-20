#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), %w'.. lib bfloco')

puts BrainfuckConverter.convert(ARGV.join(" "))