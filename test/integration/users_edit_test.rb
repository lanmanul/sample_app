require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'

  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    name = "Foo Bar"
    email = "foo@bar.com"

    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload

    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "friendly forwarding should forward only the first time" do
    # Attempt to access edit page without logging in
    get edit_user_path(@user)
    # Confirm the forwarding URL is stored
    assert_equal session[:forwarding_url], edit_user_url(@user)

    # Log in, confirm friendly forwarding to the edit page
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    # Log out, and log back in again
    delete logout_path
    log_in_as(@user)

    # Confirm user is redirected to their profile page, not the forwarding URL
    assert_redirected_to @user
    assert_nil session[:forwarding_url]
  end
end
