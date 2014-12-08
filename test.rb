require 'pty'
require 'thread'

journey_test_output = Queue.new

journey_test_thread = Thread.start do
  PTY.spawn('ruby journeys_test.rb') do |stdout, stdin, pid|
    stdout.each do |line|
      journey_test_output.enq(line)
    end
  end
end

system "ruby java_test.rb"

while journey_test_thread.alive? || !journey_test_output.empty? do
  puts journey_test_output.pop unless journey_test_output.empty?
end