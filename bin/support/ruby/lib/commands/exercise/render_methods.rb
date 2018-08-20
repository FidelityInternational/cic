require 'digest'
module Exercise
  module RenderMethods
    include Commandline::Output
    include Instructions

    attr_reader :exercise_path

    def render_exercises(dir:, original_dir: Dir.pwd, pretty_exercise_path: nil)
      @exercise_path = pretty_exercise_path
      status = true
      templates(dir).each do |exercise_name, template|
        status = false unless render_exercise(exercise_name, template)
        Dir.chdir(original_dir)
      end
      status
    end

    def render_exercise(exercise_name, template)
      say "Generating file for: #{exercise_name}"

      result = anonymise(render(template))
      result << "\nRevision: #{digest(template)}"
      File.write(exercise_filename(template), result)

      say ok "Finished: #{exercise_name}"
      true
    rescue StandardError => e
      say error "Failed to generate file from: #{template}"
      say "#{e.message}\n#{e.backtrace}"
      false
    end

    def substitute hash
      @substitutes = hash
    end

    private

    def anonymise(string)
      substitutes.each do |key, value|
        string = string.gsub(key, value)
      end
      string.gsub(/cic_container-[\w\d-]+/, 'cic_container-xxxxxxxxxxxxxxxx')
    end

    def digest(template)
      Digest::SHA2.file(template).hexdigest
    end

    def exercise_filename(template)
      "#{Dir.pwd}/#{File.basename(template, '.erb')}"
    end

    def render(template)
      anonymise(ERB.new(File.read(template)).result(binding))
    ensure
      after_all_commands.each { |command| test_command(command) }
      say '' if quiet?
    end

    def substitutes
      @substitutes ||= {}
    end

    def templates(dir)
      templates = {}
      Dir["#{dir}/.templates/*.md.erb"].each do |template|
        templates[File.basename(template)] = template
      end
      templates
    end
  end
end
