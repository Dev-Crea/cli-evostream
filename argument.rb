# frozen_string_literal: true

module Argument
  def self.read_argument()
    ARGV.each_with_index do |argument, index|
      unless index.zero?
        puts "Argument --> #{argument}"
      end
    end
  end
end
