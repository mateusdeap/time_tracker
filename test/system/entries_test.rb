require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  setup do
    @entry = entries(:one)
  end

  test "visiting the index" do
    visit entries_url
    assert_selector "h1", text: "Entries"
  end

  test "should create entry" do
    visit entries_url
    click_on "Create Entry"

    assert_selector "div#entries", text: "MyText"
  end

  test "should update Entry" do
    visit entries_url
  end

  test "should destroy Entry" do
    visit entries_url
  end
end
