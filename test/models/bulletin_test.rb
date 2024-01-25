# frozen_string_literal: true

require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  setup do
    @bulletin_one = bulletins(:one)
  end

  test 'bulletin should be in draft state' do
    assert @bulletin_one.draft?
  end
  test 'transitions to under_moderation state' do
    @bulletin_one.to_moderate
    assert @bulletin_one.under_moderation?
  end

  test 'transitions to published state' do
    @bulletin_one.to_moderate
    @bulletin_one.publish
    assert @bulletin_one.published?
  end

  test 'transitions to rejected state' do
    @bulletin_one.reject
    assert @bulletin_one.rejected?
  end

  test 'transitions to archived state' do
    @bulletin_one.archive
    assert @bulletin_one.archived?
  end
end
