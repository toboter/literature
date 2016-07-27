require 'test_helper'

class SubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subject = subjects(:one)
  end

  test "should get index" do
    get subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_subject_url
    assert_response :success
  end

  test "should create subject" do
    assert_difference('Subject.count') do
      post subjects_url, params: { subject: { abbr: @subject.abbr, edition: @subject.edition, first_page: @subject.first_page, g_canonical_link: @subject.g_canonical_link, g_image_thumbnail: @subject.g_image_thumbnail, g_volume_id: @subject.g_volume_id, language: @subject.language, last_page: @subject.last_page, page_count: @subject.page_count, parent_id: @subject.parent_id, place_id: @subject.place_id, published_date: @subject.published_date, publisher_id: @subject.publisher_id, slug: @subject.slug, subtitle: @subject.subtitle, title: @subject.title, type: @subject.type, volume: @subject.volume } }
    end

    assert_redirected_to subject_url(Subject.last)
  end

  test "should show subject" do
    get subject_url(@subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_subject_url(@subject)
    assert_response :success
  end

  test "should update subject" do
    patch subject_url(@subject), params: { subject: { abbr: @subject.abbr, edition: @subject.edition, first_page: @subject.first_page, g_canonical_link: @subject.g_canonical_link, g_image_thumbnail: @subject.g_image_thumbnail, g_volume_id: @subject.g_volume_id, language: @subject.language, last_page: @subject.last_page, page_count: @subject.page_count, parent_id: @subject.parent_id, place_id: @subject.place_id, published_date: @subject.published_date, publisher_id: @subject.publisher_id, slug: @subject.slug, subtitle: @subject.subtitle, title: @subject.title, type: @subject.type, volume: @subject.volume } }
    assert_redirected_to subject_url(@subject)
  end

  test "should destroy subject" do
    assert_difference('Subject.count', -1) do
      delete subject_url(@subject)
    end

    assert_redirected_to subjects_url
  end
end
