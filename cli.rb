#!/usr/bin/env ruby

# Load dependencies
require 'active_support/all'
require 'evostream/event'
require 'yaml'
require './command'
require './argument'

# Load configuration
load 'evostream_cli.rb'

# Prepare command
Command.read_command

# Execute command
# Argument.read_argument
