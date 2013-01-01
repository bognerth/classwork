class QuestionsController < ApplicationController
  def index
    @cur_page = Question.where(:category_id => params[:category_id]).count >= params[:page].to_i ? params[:page] : 1
    @questions = Question.where(:category_id => params[:category_id]).page(@cur_page).per_page(1)
    if @questions.empty?
      @question = Question.new
      @question.category_id = params[:category_id]
      #raise @questions.to_yaml
    else
      @question = @questions.first
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  def update
    @question = Question.find(params[:id])
    page = params[:page].to_i + 1

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to category_questions_path(params[:question][:category_id], :page => page), notice: 'UPDATE erfolgreich.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @question.category_id = params[:category_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to category_questions_path(@question.category_id, :page => Question.where(:category_id => @question.category_id).count), notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
end
