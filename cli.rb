#!/usr/bin/env ruby

# Load dependencies
require 'active_support/all'
require 'evostream/event'
require 'yaml'
require './lib/app/command'
require './lib/app/argument'

# Load configuration
load './lib/app/evostream_cli.rb'

# Prepare command
Command.read_command

# Execute command
# Argument.read_argument
