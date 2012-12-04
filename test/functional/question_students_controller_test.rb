require 'test_helper'

class QuestionStudentsControllerTest < ActionController::TestCase
  setup do
    @question_student = question_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_student" do
    assert_difference('QuestionStudent.count') do
      post :create, question_student: { question_id: @question_student.question_id, student_id: @question_student.student_id, test_id: @question_student.test_id }
    end

    assert_redirected_to question_student_path(assigns(:question_student))
  end

  test "should show question_student" do
    get :show, id: @question_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_student
    assert_response :success
  end

  test "should update question_student" do
    put :update, id: @question_student, question_student: { question_id: @question_student.question_id, student_id: @question_student.student_id, test_id: @question_student.test_id }
    assert_redirected_to question_student_path(assigns(:question_student))
  end

  test "should destroy question_student" do
    assert_difference('QuestionStudent.count', -1) do
      delete :destroy, id: @question_student
    end

    assert_redirected_to question_students_path
  end
end
