require "minitest/autorun"
require "date"

require_relative '../lib/review_range.rb'

class TestReviewRangeTwoSeconds < Minitest::Test
  def setup
    @review_range = ReviewRange.new(
      start: [2016,1,16,2,50,0],
      stop: [2016,1,16,2,50,2],
      increment_phrase: "in 2 seconds"
    )
  end

  def test_next
    @review_range.next { |slice_begin, slice_end|
      assert_equal("#{slice_begin} #{slice_end}", "2016-01-16T02:50:00Z 2016-01-16T02:50:02Z")
    }
  end

end

