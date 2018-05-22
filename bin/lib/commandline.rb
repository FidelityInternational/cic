require 'colorize'

module Commandline
  def say msg
    puts msg
  end

  def ok text
    "[OK] #{text}".green
  end

  def error text
    "[ERROR] #{text}".red
  end

  private
  def no_colour
    '\033[0m'
  end
end
