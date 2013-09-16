class Student < Sequel::Model
  def self.without_subscriptions
    left_outer_join(:subscriptions, student_id: :id).
      where("subscriptions.student_id is null")
  end
end
