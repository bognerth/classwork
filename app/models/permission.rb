class Permission < Struct.new(:user)
  def allow?(controller, action)
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w[new create])
    #return true if controller == "topics" && action.in?(%w[index show])
    if user
      return true if controller == "users" && action.in?(%w[edit update])
      return true if controller == "test_students"
      return true if controller == "answer_students"
      return true if user.student.group.name == 'Lehrer'
    end
    false
  end
end