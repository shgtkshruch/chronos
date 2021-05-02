class Person < ApplicationRecord
  validates :name, :birthday, :day_of_death, presence: true
end
