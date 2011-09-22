#!/usr/bin/env ruby

# 
# == Synopsis
#
# tsung-driver: used to generate tsung XML from api test branch and initiate load
#
# == Usage
#
# driver.rb [OPTIONS] ... SUITE_FILE_NAME KS_CONTEXT RICE_CONTEXT
#
# -h, --help:
#     show help
#
# -c, --config [file.xml]:
#     path to xml config file for everything after <tsung> and before <sessions> : NOT CURRENTLY SUPPORTED
#
# -d, --debug:
#     enable debug logging
#
# -t, --thinktime
#     enable thinktime sleeps (simulates user input delays)
#
# -v, --verbose:
#     will dump http traffic from tsung, only is in effect in -x is used
#
# -x, --execute:
#     start the load after generating the XML. If not specified, only XML will be generated.
#
# -o, --output:
#     filename(path) that you want to use for output XML
#
# -s, --sso [cas URL]:
#     CAS login URL : NOT CURRENTLY SUPPORTED
#
# SUITE_FILE_NAME:
#     suite file name containg list of tests. File must exist in suites directory
#
# KS_CONTEXT:
#     context for the KS app , e.g. ks-embedded
#
# RICE_CONTEXT:
#     context for the RICE app , e.g. ks-rice
#
# == Examples
#
#

require 'optparse'
#require 'rdoc/usage'
require File.dirname(__FILE__) + '/lib/common.rb'
require File.dirname(__FILE__) + '/lib/config.rb'
require 'drb'
include Common

########

errors = [] # Gather arg validation errors

# Initialize true/false vars
config = AutoConfig.new
option = false

# Get cmd line options
optparse = OptionParser.new do |opts|
  
  # Banner
  opts.banner = "Usage: driver.rb [OPTIONS] ... SUITE_FILE_NAME APP_CONTEXT RICE_CONTEXT"
  
  # Definition of options
  opts.on('-h', '--help', 'Display help screen') do
    puts opts
    exit
  end
  
  # Config file
  opts.on('-c', '--config FILE', 'path to xml config file for everything after <tsung> and before <sessions> : NOT CURRENTLY SUPPORTED') do |file|
    config.intro_xml = file
    errors.push("#{opt} does not exist") unless(File.file?(config.intro_xml))
    option = true
  end
  
  # Output xml file
  opts.on('-o', '--output FILE', 'path to xml output') do |file|
    config.output = file
  end
  
  # Log file
  opts.on('-l', '--log FILE', 'path to log output from this framework') do |file|
    config.log_path = file
  end
  
  # Execute tests after generating xml
  config.execute = nil
  opts.on('-x', '--execute', 'start the load after generating the XML') do
    config.execute = true
  end
  
  # Verbose option for tsung
  config.verbose = nil
  opts.on('-v', '--verbose', 'dumps http traffic from tsung') do
    config.verbose = true
  end
  
  # Log level for Tsung
  config.tsung_log_level = 'notice'
  opts.on('-t', '--tsung_log_level LEVEL', 'sets the log level for tsung. Available levels: emergency, critical, error, warning, notice (default), info, debug') do |level|
    if(level != 'emergency' and level != 'critical' and level != 'error' and level != 'warning' and level != 'notice' and level != 'info' and level != 'debug')
      puts "Invalid setting for -t"
      puts opts
      exit
    else
      config.tsung_log_level = level
    end
  end

  # Enable debug
  opts.on('-d', '--debug', 'enable debug logging') do
    config.debug = true
  end
  
  # Enable thinktime
  config.thinktime = nil
  opts.on('-t', '--thinktime', 'enable thinktime sleeps') do
    config.thinktime = true
  end
  
  # SSO
  config.sso = false
  opts.on('-s', '--sso URL', 'CAS login URL: NOT CURRENTLY SUPPORTED') do |url|
    config.sso = url
  end
  
  
end

optparse.parse!

# Need to collect drb port
config.drb_port = ENV['DRB_PORT']
errors << "Must specify DRB_PORT in shell environment" unless(!config.drb_port.nil?)

# Exit if we have problems
if(!errors.empty?)
  errors.each { |err| puts "#{err}" }
  exit
end

if(ARGV.length != 3)
  puts "Must specify test suite and app contexts"
  exit 2
end

# Validate suite file in suites dir
config.suite = ARGV.shift
config.context = ARGV.shift
config.rice_context = ARGV.shift

exit 3 if(!config.validate_suite)
config.parse_suite

# If no options are passed then we'll use interactive setup
config.initialize_logs
config.setup if(!option)

# write initial config XML here before we get to tests if no -c option was secified
config.initialize_output_xml


config.log.debug_msg("----------CONFIG----------")
config.log.debug_msg(config.inspect)
config.log.debug_msg("--------------------------")
#
# EXECUTE TESTS
#

# Fire up service for tests to read config information from
DRb.start_service "druby://localhost:#{config.drb_port}", config
config.log.debug_msg("DRB service running at #{DRb.uri}")

begin
  
  # Write <sessions> container
  config.init_sessions
  
  config.tests.each_key do |test|
    puts `#{config.test_dir}/#{test}`
  end
  
end

config.xml_obj.write($stdout, 2) if(config.debug) # Dump out xml
config.xml_obj.write(config.xml_writer.file, 2) # Write xml to file
config.xml_writer.file.close # Need to close so Tsung can open the file


if(config.execute)
  # Launch tsung
  config.log.info_msg("Starting tsung with command [tsung -f #{config.xml_writer.file_path} start]")
  puts `tsung -f #{config.xml_writer.file_path} start`
end

DRb.stop_service