require 'pty'
require 'thread'

class ContainedThread
  attr_reader :succeeded

  def initialize
    @output = Queue.new
  end

  def start(command)
    @thread = Thread.start do
      PTY.spawn(command) do |stdout, _, pid|
        enqueue_output(stdout)
        @succeeded = exit_success?(pid)
      end
    end
  end

  def blocking_print
    while @thread.alive? || !@output.empty? do
      puts @output.pop unless @output.empty?
    end
  end

  private

  def enqueue_output(stdout)
    stdout.each do |line|
      @output.enq(line)
    end
  end

  def exit_success?(pid)
    Process.wait2(pid)[1].exitstatus == 0
  end
end

journey_test_thread = ContainedThread.new
journey_test_thread.start('ruby journeys_test.rb')

java_tests_passed = system 'ruby java_test.rb'

journey_test_thread.blocking_print

exit journey_test_thread.succeeded && java_tests_passed