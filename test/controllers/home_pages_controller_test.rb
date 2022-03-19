require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Card Match"
  end

  test 'should get top' do
    get home_pages_top_url
    assert_response :success
    assert_select "title", "トップページ | #{@base_title}"
  end

  test 'should get about' do
    get home_pages_about_url
    assert_response :success
    assert_select "title", "使い方 | #{@base_title}"
  end
end
