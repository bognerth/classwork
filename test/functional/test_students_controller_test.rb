require 'test_helper'

class TestStudentsControllerTest < ActionController::TestCase
  setup do
    @test_student = test_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_student" do
    assert_difference('TestStudent.count') do
      post :create, test_student: { end: @test_student.end, points: @test_student.points, start: @test_student.start, student_id: @test_student.student_id, test_id: @test_student.test_id }
    end

    assert_redirected_to test_student_path(assigns(:test_student))
  end

  test "should show test_student" do
    get :show, id: @test_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_student
    assert_response :success
  end

  test "should update test_student" do
    put :update, id: @test_student, test_student: { end: @test_student.end, points: @test_student.points, start: @test_student.start, student_id: @test_student.student_id, test_id: @test_student.test_id }
    assert_redirected_to test_student_path(assigns(:test_student))
  end

  test "should destroy test_student" do
    assert_difference('TestStudent.count', -1) do
      delete :destroy, id: @test_student
    end

    assert_redirected_to test_students_path
  end
end
