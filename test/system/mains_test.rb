require "application_system_test_case"

class MainsTest < ApplicationSystemTestCase
  # setup do
  #   @user = users(:ddd)
  # end
  test "login success" do
    visit "/main"
    fill_in "Email", with: "ddd"
    fill_in "Password", with: "ddd"
    click_on "Login"
    assert_selector "h1", text: "ddd"
  end
  test "login wrong password" do
    visit "/main"
    fill_in "Email", with: "ddd"
    fill_in "Password", with: "aaa"
    click_on "Login"
    assert_selector "p", text: "Wrong password"
  end
  test "login wrong user" do
    visit "/main"
    fill_in "Email", with: "asdfasdf"
    fill_in "Password", with: "aaa"
    click_on "Login"
    assert_selector "p", text: "Incorrect email"
  end
  test "like on feed" do
    visit "/main"
    fill_in "Email", with: "ddd"
    fill_in "Password", with: "ddd"
    click_on "Login"
    find('[id="10"]').find('input').click
    visit "/profile/sss"
    assert_equal "Like: 1", find('[id="10"]').find('a[href="#"]').text
  end
end
