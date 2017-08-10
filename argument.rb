# frozen_string_literal: true

# Parse argument for used with command sending to evostream
module Argument
  def self.read_argument
    ARGV.each_with_index do |argument, index|
      puts "Argument --> #{argument}" unless index.zero?
    end
  end
end
