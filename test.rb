require_relative 'contained_thread'

journey_test_thread = ContainedThread.start('ruby journeys_test.rb')

java_tests_passed = system 'ruby java_test.rb'

journey_test_thread.blocking_print

exit journey_test_thread.succeeded && java_tests_passed