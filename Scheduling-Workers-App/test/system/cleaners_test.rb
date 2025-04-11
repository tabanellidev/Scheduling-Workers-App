require "application_system_test_case"

class CleanersTest < ApplicationSystemTestCase
  setup do
    @cleaner = cleaners(:one)
  end

  test "visiting the index" do
    visit cleaners_url
    assert_selector "h1", text: "Cleaners"
  end

  test "should create cleaner" do
    visit cleaners_url
    click_on "New cleaner"

    fill_in "Birthdate", with: @cleaner.birthdate
    fill_in "Hired", with: @cleaner.hired
    fill_in "Name", with: @cleaner.name
    fill_in "Residence", with: @cleaner.residence
    fill_in "Surname", with: @cleaner.surname
    click_on "Create Cleaner"

    assert_text "Cleaner was successfully created"
    click_on "Back"
  end

  test "should update Cleaner" do
    visit cleaner_url(@cleaner)
    click_on "Edit this cleaner", match: :first

    fill_in "Birthdate", with: @cleaner.birthdate
    fill_in "Hired", with: @cleaner.hired
    fill_in "Name", with: @cleaner.name
    fill_in "Residence", with: @cleaner.residence
    fill_in "Surname", with: @cleaner.surname
    click_on "Update Cleaner"

    assert_text "Cleaner was successfully updated"
    click_on "Back"
  end

  test "should destroy Cleaner" do
    visit cleaner_url(@cleaner)
    click_on "Destroy this cleaner", match: :first

    assert_text "Cleaner was successfully destroyed"
  end
end
