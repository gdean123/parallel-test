require_relative 'parallel_test_runner'

ParallelTestRunner.run('ruby journeys_test.rb', 'ruby java_test.rb')