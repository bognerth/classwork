class StudentsController < ApplicationController
  #Umfunktioniert: zeigt die testergebnisse von students
  def index
    @results = TestStudent.where(test_id: params[:test_id])
    if @results.empty?
      redirect_to tests_path, notice: 'Keine Ergebnisse vorhanden'
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @students }
      end
    end
  end
  #Umfunktioniert, zeigt die Testergebnisse als pdf zum speichern
  def show
    @test_students = TestStudent.where(test_id: params[:id])  #test_id wird in der index.htm.erb mitgegeben
    
    respond_to do |format|
      format.html # new.html.erb
      format.pdf do
        pdf = TestResultPdf.new(@test_students)
        send_data pdf.render, filename: "Testergebnis-#{@test_students[0].test.description}-#{DateTime.now.to_s}",
                            type: "application/pdf",
                            disposition: "inline"
      end
    end
  end

  def new
    @student = Student.new


  end

  def edit
    @teststudent = TestStudent.find(params[:id])
    @student = Student.find(@teststudent.student_id)
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @teststudent = TestStudent.find(params[:teststudent_id])

    respond_to do |format|
      if @teststudent.update_attributes(:points => params[:points])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.js
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end
end
