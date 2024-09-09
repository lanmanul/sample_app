require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael) # Assuming Michael is a valid user in your fixtures
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

test "layout links for logged-in users" do
  log_in_as(@user) # Assuming log_in_as is a valid helper method for testing
  get root_path
  assert_template 'static_pages/home'

  # Check that logged-in users can see these links
  assert_select "a[href=?]", root_path, count: 2
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", user_path(@user) # Profile link
  assert_select "a[href=?]", edit_user_path(@user) # Settings link
  assert_select "a[href=?]", logout_path # Logout link

  # Logged-in users should not see the login link
  assert_select "a[href=?]", login_path, count: 0
  end
end