require 'colorize'
require 'open3'


module Commandline
  class Return
    attr_reader :stdout, :stderr, :exit_code
    def initialize(stdout:, stderr:, exit_code:)
      @stdout = normalise(stdout)
      @stderr = normalise(stderr)
      @exit_code = exit_code
    end

    def error?
      exit_code != 0
    end

    def to_s
      <<OUTPUT
EXIT CODE: #{exit_code}

STDOUT:
#{stdout}

STDERR:
#{stderr}
OUTPUT

    end

    private
    def normalise string
      string.chomp.strip
    end
  end

  def run(command)
    stdout, stderr, status = Open3.capture3(command)
    Return.new(stdout: stdout, stderr: stderr, exit_code: status.exitstatus)
  end

  module Output
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



end
