class Activity < Sequel::Model
  def self.open_for_subscription(day)
    where(day: day)
  end
end
