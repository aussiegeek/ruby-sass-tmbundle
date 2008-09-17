require 'rubygems'
require 'spec'

ENV['TM_SUPPORT_PATH'] = '/Applications/TextMate.app/Contents/SharedSupport/Support'

require File.expand_path(File.join(File.dirname(__FILE__), "../lib", "sass_engine"))