# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create Instructior accoutn
User.create(email: "instructor@test.com",
            name: "John",
            surname: "Doe",
            role: "instructor",
            password: "Test123456",
            password_confirmation: "Test123456")
puts "Created instructor account."


User.create(
    email: "student@test.com",
    name: "Lorena",
    surname: "Avduli",
    role: "student",
    password: "Test123456",
    password_confirmation: "Test123456"
)

puts "Created student account"

Course.create(
    name: "Ruby on Rails",
    code: "Cs101",
    semester: "1"
)

puts "Created course"

AssessmentItem.create(
    course: Course.last,
    name: "Midterm",
    weight: 0.5
)

puts "Crested assessment item"

student = User.where(role: "student").last
Grade.create(
    user: student,
    course: Course.last,
    assessment_item: AssessmentItem.last,
    exam: "Final Exam",
    score: 90
)

puts "Created Grade"
