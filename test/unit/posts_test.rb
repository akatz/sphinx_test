require 'test_helper'

class PostsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Posts.new.valid?
  end
end
