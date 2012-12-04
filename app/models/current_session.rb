class CurrentSession < ActiveRecord::Base
  attr_accessible :course_id, :email, :group_id, :student_id, :courses, :tests, :state, :c_category_id, :c_test_id, :user_id, :c_test_student_id, :c_count_questions, :c_start, :c_duration
    
  serialize :courses
  serialize :tests

  def make(user_id)
   	student = Student.find_by_user_id(user_id)
   	self.user_id = user_id 
   	self.student_id = student.id
   	self.group_id = student.group_id
   	self.email = student.user.email
   	unless self.group_id == 1
   		courses = Course.find_all_by_group_id(student.group_id)
   		courseids = courses.map{|course| course.id}
      self.courses = courseids
      existingtests = courses.map{|c| c.tests unless c.tests.empty? } if courses
      self.tests = existingtests.last.map{|t| t.id unless t.nil? } if existingtests
   		opentests = Test::open_tests
      ctests = opentests.select{|t| t if courseids.include?(t.course_id) }
      self.state = 'logged_in'
      #raise ctests.to_yaml
      ctest = ctests.last
      #raise ctest.to_yaml
      if ctest #&& ctest.first && ctest.first.id > 0
        self.c_category_id = ctest.category_id
   		  self.c_test_id = ctest.id
        self.c_count_questions = Question.find_all_by_category_id(ctest.category_id)
        self.c_duration = ctest.duration
      end
   	end
   	save
  end

end
