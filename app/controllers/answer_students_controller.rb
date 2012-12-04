class AnswerStudentsController < ApplicationController
  # POST /answer_students
  # POST /answer_students.json
  def create
    answer = Answer.find(params[:answer_student][:answer_id])
    params[:answer_student][:points] = answer.points
    @answer_student = AnswerStudent.new(params[:answer_student])
    page = params[:page].to_i + 1
    respond_to do |format|
      if @answer_student.save
        format.html { redirect_to test_student_path(current_user.c_test_student_id, :page => page), notice: 'Auswahl gespeichert.' }
        format.json { render json: @answer_student, status: :created, location: @answer_student }
      else
        format.html { render action: "new" }
        format.json { render json: @answer_student.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to test_student_path(current_user.c_test_student_id, :page => params[:page]), notice: 'Waehlen Sie eine Antwort.' 
  end

  # PUT /answer_students/1
  # PUT /answer_students/1.json
  def update
    @answer_student = AnswerStudent.find(params[:id])
    page = params[:page].to_i + 1
    respond_to do |format|
      if @answer_student.update_attributes(params[:answer_student])
        format.html { redirect_to test_student_path(current_user.c_test_student_id, :page => page), notice: 'UPDATE erfolgreich.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer_student.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /answer_students
  # GET /answer_students.json
  def index
    @answer_students = AnswerStudent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answer_students }
    end
  end

  # GET /answer_students/1
  # GET /answer_students/1.json
  def show
    @answer_student = AnswerStudent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer_student }
    end
  end

  # GET /answer_students/new
  # GET /answer_students/new.json
  def new
    @answer_student = AnswerStudent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer_student }
    end
  end

  # GET /answer_students/1/edit
  def edit
    @answer_student = AnswerStudent.find(params[:id])
  end




  # DELETE /answer_students/1
  # DELETE /answer_students/1.json
  def destroy
    @answer_student = AnswerStudent.find(params[:id])
    @answer_student.destroy

    respond_to do |format|
      format.html { redirect_to answer_students_url }
      format.json { head :no_content }
    end
  end
end
