require_relative 'contained_thread'

commands = ['ruby journeys_test.rb', 'ruby java_test.rb']

threads = commands.map do |command|
  ContainedThread.start(command)
end

threads.each do |command|
  command.blocking_print
end

all_succeeded = threads.reduce(true) do |all_succeeded, command|
  all_succeeded && command.succeeded
end

exit all_succeeded