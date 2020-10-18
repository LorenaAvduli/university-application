module GradesHelper
  def display_assessment_items(course)
    if params[:action] == "edit"
      course.assessment_items.pluck(:name, :id)
    else
      []
    end
  end

  def display_courses(user)
    if params[:action] == "edit"
      user.courses.pluck(:name, :id)
    else
      []
    end
  end

  def compute_overall_grade
    #E.g. given three assessments Midterm 25%, Project 35%, Final Exam
    # 40% and respective grades 80, 70, 90 the overall computed grade is
    # the weighted average 0.25×80 + 0.35×70 + 0.40×90 = 80.5
    grades = current_user.grades.group_by { |grade|  grade.course_id }
    response = "<ul class='list-group list-group-flush'>"
    grades.each do | key, values|
      total = 0.0
      values.each do |g|
        assessment_item_weight = g.assessment_item.weight
        score = g.score
        total += assessment_item_weight * score
      end
      response += "<li class='list-group-item'> #{values[0].course.name.capitalize}: #{total} </li>"
    end
    response += "</ul>"
    response.html_safe
  end
end
