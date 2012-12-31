class TestStudentPdf < Prawn::Document
  def initialize(test_student)
    super(top_margin: 70)
    @test_student = test_student
    @category = Category.find(@test_student.test.category_id)
    @prozent = (@test_student.points * 100 / @test_student.count_questions).round
    @antworten = AnswerStudent.get_answer_hash(@test_student.id)

    text "Testergebnis", size: 30, style: :bold
    move_down 20
    text "#{@test_student.points} richtige Antworten bei #{@test_student.count_questions} Fragen ergibt #{@prozent} %."
    move_down 15
    text "Das ergibt die Note: #{POINTS_TO_NOTE[@prozent]}."
    move_down 20
    @category.questions.each do |question|
      line_items(question)
    end
  end

  def line_items(question)
    @question = question
    move_down 20
    table line_item_rows do
      self.width = 540
      row(0).font_style = :bold
      columns(0).align = :center
      columns(0).width = 30
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [['',@question.text]] +
    @question.answers.map do |answer|
      [self.answer_grafik(answer),answer.text]
      #[{:image => self.answer_grafik(answer)}, answer.text]
    end
  end

  def answer_grafik(answer)
    if answer.points == 1 && @antworten[answer.id] == 1
      grafik = "1" #ok.png"
    elsif answer.points == 1
      grafik = "x" #plus.png"
    elsif @antworten[answer.id]
      grafik = "0" #cross.png"
    else
      grafik = "" #ok.png"
    end
    #{Rails.root}/app/assets/images/#{grafik}"
    grafik
  end
end