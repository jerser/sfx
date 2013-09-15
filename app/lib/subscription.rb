class Subscription < Sequel::Model
  def self.subscribe(student_id, activity_id)
    ss = Subscription.new
    ss.student_id = student_id
    ss.activity_id = activity_id
    ss.save
  end
end
