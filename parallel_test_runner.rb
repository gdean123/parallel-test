require_relative 'contained_process'

class ParallelTestRunner
  def self.run(*commands)
    processes = start_processes(commands)
    print_output(processes)
    exit all_succeeded?(processes)
  end

  private

  def self.start_processes(commands)
    commands.map do |command|
      ContainedProcess.start(command)
    end
  end

  def self.print_output(processes)
    processes.each do |command|
      command.blocking_print
    end
  end

  def self.all_succeeded?(processes)
    processes.reduce(true) do |all_succeeded, process|
      all_succeeded && process.succeeded
    end
  end
end