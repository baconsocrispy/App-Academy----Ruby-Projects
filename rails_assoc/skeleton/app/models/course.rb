class Course < ApplicationRecord
  has_many :enrollments,
    class_name: :Enrollment,
    primary_key: :id,
    foreign_key: :course_id
  
  belongs_to :prerequisite,
    class_name: :Course,
    primary_key: :id,
    foreign_key: :prereq_id
  
  has_one :instructor, 
    class_name: :User,
    primary_key: :instructor_id,
    foreign_key: :id
end
