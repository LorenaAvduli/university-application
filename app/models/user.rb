class User < ApplicationRecord
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :grades
  has_many :user_courses
  has_many :courses, through: :user_courses

  validates_presence_of :name, :surname
  validates :name, :surname,length: { maximum: 30 }
  validate :max_chars_name_surname
  validate :password_requirements_are_met

  enum role: {instructor: "instructor", student: "student"}

  def full_name
    "#{name} #{surname}"
  end

  private

  def max_chars_name_surname
    errors.add(:surname, "The total number of characters for name and surname must not be greater than 50.") if (name + surname).size > 50
  end

  def password_requirements_are_met
    if password.present?
      rules = {
          " must contain at least one lowercase letter"  => /[a-z]+/,
          " must contain at least one uppercase letter"  => /[A-Z]+/,
          " must contain at least one digit"             => /\d+/
      }
      rules.each do |message, regex|
        errors.add( :password, message ) unless password&.match( regex )
      end
    end
  end


end
