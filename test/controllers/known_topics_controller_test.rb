require 'test_helper'

class KnownTopicsControllerTest < ActionController::TestCase
  setup do
    @known_topic = known_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:known_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create known_topic" do
    assert_difference('KnownTopic.count') do
      post :create, known_topic: { knowledge: @known_topic.knowledge, topic_id: @known_topic.topic_id, user_id: @known_topic.user_id }
    end

    assert_redirected_to known_topic_path(assigns(:known_topic))
  end

  test "should show known_topic" do
    get :show, id: @known_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @known_topic
    assert_response :success
  end

  test "should update known_topic" do
    patch :update, id: @known_topic, known_topic: { knowledge: @known_topic.knowledge, topic_id: @known_topic.topic_id, user_id: @known_topic.user_id }
    assert_redirected_to known_topic_path(assigns(:known_topic))
  end

  test "should destroy known_topic" do
    assert_difference('KnownTopic.count', -1) do
      delete :destroy, id: @known_topic
    end

    assert_redirected_to known_topics_path
  end
end
