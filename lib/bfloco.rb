require 'logger'
require 'yaml'
require 'net/http'
require 'rubygems'
require 'twitter'

require File.join(File.dirname(__FILE__), %w'monkeypatches array')
require File.join(File.dirname(__FILE__), %w'monkeypatches fixnum')

require File.join(File.dirname(__FILE__), %w'bfloco brainfuck_converter')
require File.join(File.dirname(__FILE__), %w'bfloco brainfuck_bot')

module BrainfuckLoco
  attr_accessor :logger, :config
  
  def self.symbolize_keys(hash)
    hash.inject({}) do |result, (key, value)|
      new_key   = key.instance_of?(String) ? key.to_sym : key
      new_value = value.instance_of?(Hash) ? symbolize_keys(value) : value
      result[new_key] = new_value
      result
    end
  end

  def self.config
    @config ||= begin
      config_file   = File.join(File.dirname(__FILE__), %w'.. config config.yml')
      symbolize_keys(YAML.load_file(config_file))
    end
  end
  
  def self.logger
    @logger ||= begin 
      log_directory = File.join(File.dirname(__FILE__), %w'.. log')
      Dir.mkdir(log_directory) unless File.exists?(log_directory)    
      Logger.new(File.join([log_directory, 'production.log']), 'monthly')
    end
  end
end