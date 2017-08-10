# frozen_string_literal: true

# Execute command given by the user
module Command
  def self.read_command
    @command = ARGV[0]

    if @command.nil?
      display_error_no_command
    else
      search_command_execute
    end
  end

  def search_command_execute
    case @command
    when '-c', '--config' then see_configuration
    when '-h', '--help' then display_help
    else
      execute_command_in_gem
    end
  end

  def self.display_error_no_command
    puts 'No command specify.'
    display_help
  end

  def self.see_configuration
    conf = Evostream::Service
    puts 'Configuration to this apps :'
    puts "URI_IN :        #{conf.uri_in}"
    puts "URI_OUT :       #{conf.uri_out}"
    puts "ENVIRPNMENT :   #{conf.environment}"
  end

  def self.display_help
    puts "CLI For EvoStream -- #{Evostream::GEM_NAME} [#{Evostream::VERSION}]"
    File.open('help', 'r') do |f|
      f.each_line do |line|
        puts line
      end
    end
  end

  def self.execute_command_in_gem
    resultat = Evostream::Action.new.execute_action(@command)
    puts "Resultat : #{resultat.class}"
    puts resultat[:data].to_yaml
  end
end
