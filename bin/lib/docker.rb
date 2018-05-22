require_relative 'commandline'
module Docker
  class Error < StandardError
    include Commandline::Output
    def initialize msg
      super error(msg)
    end
  end

  include Commandline
  def container_exists?(container_name)
    container_id(container_name) && true
  rescue Error
    false
  end

  def container_id container_name
    id = docker(%Q{container ps -aq --filter "name=#{container_name}"}).stdout
    id.empty? ? raise(Error, "container with name #{container_name} does not exist") : id
  end
  def start_container(container_name)
    container_id = container_id(container_name)
    docker("container start #{container_id} -i")
  end

  def create_container(container_name, image_tag)
    docker("run --privileged --name #{container_name} -v /sys/fs/cgroup:/sys/fs/cgroup:ro #{image_tag} /sbin/init")
  end

  def docker command
    command = "docker #{command}"
    run(command).tap do |output|
      raise(Error, "Failed to run: #{command}") unless output.exit_code == 0
    end
  end
end
