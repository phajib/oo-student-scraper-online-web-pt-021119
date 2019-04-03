require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attributes, value|
      self.send("#{attributes}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
    # binding.pry
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attributes, value|
      # binding.pry
      # Iterate through the attributes hash and get each hash's value
      self.send("#{attributes}=", value)
    end
    # binding.pry
    # return all of the values from the all array
    @@all
  end

  def self.all
    @@all
  end
end

