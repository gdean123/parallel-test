require_relative 'contained_thread'

journey_tests = ContainedThread.start('ruby journeys_test.rb')
java_tests = ContainedThread.start('ruby java_test.rb')

java_tests.blocking_print
journey_tests.blocking_print

exit journey_tests.succeeded && java_tests.succeeded