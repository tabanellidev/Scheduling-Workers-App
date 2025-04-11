require "application_system_test_case"

class RepeatableJobsTest < ApplicationSystemTestCase
  setup do
    @repeatable_job = repeatable_jobs(:one)
  end

  test "visiting the index" do
    visit repeatable_jobs_url
    assert_selector "h1", text: "Repeatable jobs"
  end

  test "should create repeatable job" do
    visit repeatable_jobs_url
    click_on "New repeatable job"

    click_on "Create Repeatable job"

    assert_text "Repeatable job was successfully created"
    click_on "Back"
  end

  test "should update Repeatable job" do
    visit repeatable_job_url(@repeatable_job)
    click_on "Edit this repeatable job", match: :first

    click_on "Update Repeatable job"

    assert_text "Repeatable job was successfully updated"
    click_on "Back"
  end

  test "should destroy Repeatable job" do
    visit repeatable_job_url(@repeatable_job)
    click_on "Destroy this repeatable job", match: :first

    assert_text "Repeatable job was successfully destroyed"
  end
end
