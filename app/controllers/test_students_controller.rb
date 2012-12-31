class TestStudentsController < ApplicationController
  # index: es gibt keinen aktuellen Test fuer den User
  # klick auf Test starten leitet zur create-Methode, dort wird ein Datensatz in Tabelle test_students angelegt
  # ob der Test abgelaufen ist laesst sich mit object.end > datetime.now ermitteln
  def index
    @tests = Test.where(:id => current_user.tests)
    if current_user.c_test_id   #es gibt einen aktuellen Test
      @cur_test = Test.find(current_user.c_test_id)
      
      if current_user.courses.nil?
        @bemerkung = "Fuer den User gibt es keinen Kurs."
      elsif current_user.state == 'finished'
        @bemerkung = "Der User hat keinen offenen Test."
      elsif current_user.c_test_id.nil?
        @bemerkung = "Es gibt keinen aktuellen Test."
      end
    else
      @bemerkung = "Es gibt keinen aktuellen Test."
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_students }
    end
  end

  def show
    @test_student = TestStudent.find(params[:id])
    @cur_page = @test_student.count_questions >= params[:page].to_i ? params[:page] : 1
    @questions = Question.where(:category_id => current_user.c_category_id, :status => true).order(:id).page(@cur_page).per_page(1)
    @answer_student = AnswerStudent.find_or_initialize_by_student_id_and_test_id_and_question_id(@test_student.student_id,@test_student.test_id,@questions.first.id)
    @answer_student.test_student_id = params[:id]
    #@answer_student = AnswerStudent.new
    #@answer_student.student_id = current_user.student_id
    #@answer_student.test_id = current_user.test_id
    #@cur_page = params[:page]
    @answers = Answer.where(:question_id => @questions.first.id) 
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_student }
    end 
  end

  def create
    if TestStudent.exists?(:test_id => current_user.c_test_id, :student_id => current_user.student_id)
      @current_session = CurrentSession.find(current_user.id)
      @current_session.update_attributes(:state => 'finished')
      redirect_to test_students_path, :notice => "Der User #{current_user.email} hat den Test schon einmal durchgefuehrt."
    else
      test = Test.find(current_user.c_test_id)
      now = DateTime.now
      ende = current_user.c_duration.minutes.from_now
      count = Question.where(:category_id => current_user.c_category_id).count
      @test_student = TestStudent.new(test_id: current_user.c_test_id, student_id: current_user.student_id, start: now, :end => ende, count_questions: count, current_question_id: 0, points: 0)

      if @test_student.save
        current_session = CurrentSession.find(current_user.id)
        current_session.update_attributes(:c_test_student_id => @test_student.id, :state => 'started', :c_count_questions => count, :c_start => now)
        redirect_to test_student_path(@test_student)
      else
        redirect_to test_students_path, :notice => "Fehler beim Anlegen eines Test fuer User #{current_user.email}."
      end
    end
  end

  def update
    @test_student = TestStudent.find(params[:id])
    @test_student.update_attributes(:points => @test_student.answer_students.sum(:points))
    @current_session = CurrentSession.find(current_user.id)
    @current_session.update_attributes(:state => 'finished')
    @category = Category.find(@current_session.c_category_id)
    @prozent = (@test_student.points * 100 / @test_student.count_questions).round
    @antworten = AnswerStudent.get_answer_hash(@test_student.id)
  end

  # GET /test_students/new
  # GET /test_students/new.json
  def new
    @test_student = TestStudent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_student }
    end
  end

  # GET /test_students/1/edit
  def edit
    @test_student = TestStudent.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.pdf do
        pdf = TestStudentPdf.new(@test_student)
        send_data pdf.render, filename: "Testergebnis-#{current_user.email}",
                            type: "application/pdf",
                            disposition: "inline"
      end
    end
  end


  # DELETE /test_students/1
  # DELETE /test_students/1.json
  def destroy
    @test_student = TestStudent.find(params[:id])
    @test_student.destroy

    respond_to do |format|
      format.html { redirect_to test_students_url }
      format.json { head :no_content }
    end
  end
end
