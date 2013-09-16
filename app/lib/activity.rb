class Activity < Sequel::Model
  def self.open_for_subscription(day)
    DB.transaction do
      activity_ids = left_outer_join(:subscriptions, activity_id: :id).
        where("activities.day = ?", day).
        select_group(:id).
        having("count(subscriptions.*) < activities.limit").to_a.map do |a|
          a.id
      end

      where("id IN ?", activity_ids)
    end
  end
end
