require_relative 'contained_thread'

class ParallelTestRunner
  def self.run(*commands)
    threads = start_threads(commands)
    print_output(threads)
    exit all_succeeded?(threads)
  end

  private

  def self.start_threads(commands)
    commands.map do |command|
      ContainedThread.start(command)
    end
  end

  def self.print_output(threads)
    threads.each do |command|
      command.blocking_print
    end
  end

  def self.all_succeeded?(threads)
    threads.reduce(true) do |all_succeeded, command|
      all_succeeded && command.succeeded
    end
  end
end