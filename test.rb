require_relative 'parallel_test_runner'

ParallelTestRunner.run('ruby java_test.rb', 'ruby journeys_test.rb')