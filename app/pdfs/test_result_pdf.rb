class TestResultPdf < Prawn::Document
  def initialize(test_students)
    super(top_margin: 70)
    @test_students = test_students
    
    text "Test: #{@test_students[0].test.description}", size: 30, style: :bold
    move_down 20
    text "Stand: #{DateTime.now}"
    move_down 20

    @test_students.each do |result|
      line_items(result)
    end
  end

  def line_items(result)
    @result = result
    move_down 20
    table line_item_rows do
      self.width = 540
      row(0).font_style = :bold
      columns(0).align = :left
      columns(0).width = 300
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    punkte = ((@result.points * 100) / @result.count_questions).round
    [[@result.student.user.email,punkte,POINTS_TO_NOTE[punkte]]] 
  end

end