require "test_helper"

class RepeatableJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repeatable_job = repeatable_jobs(:one)
  end

  test "should get index" do
    get repeatable_jobs_url
    assert_response :success
  end

  test "should get new" do
    get new_repeatable_job_url
    assert_response :success
  end

  test "should create repeatable_job" do
    assert_difference("RepeatableJob.count") do
      post repeatable_jobs_url, params: { repeatable_job: {} }
    end

    assert_redirected_to repeatable_job_url(RepeatableJob.last)
  end

  test "should show repeatable_job" do
    get repeatable_job_url(@repeatable_job)
    assert_response :success
  end

  test "should get edit" do
    get edit_repeatable_job_url(@repeatable_job)
    assert_response :success
  end

  test "should update repeatable_job" do
    patch repeatable_job_url(@repeatable_job), params: { repeatable_job: {} }
    assert_redirected_to repeatable_job_url(@repeatable_job)
  end

  test "should destroy repeatable_job" do
    assert_difference("RepeatableJob.count", -1) do
      delete repeatable_job_url(@repeatable_job)
    end

    assert_redirected_to repeatable_jobs_url
  end
end
