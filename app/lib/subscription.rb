class Subscription < Sequel::Model
  def self.subscribe(student_id, activity_ids)
    is_subscribed = true
    DB.transaction do
      activity_ids = [activity_ids] unless activity_ids.is_a? Array
      activity_ids.each do |activity_id|
        limit   = Activity.where(id: activity_id).first[:limit]
        current = Subscription.where(activity_id: activity_id).count

        if current < limit
          ss = Subscription.new
          ss.student_id = student_id
          ss.activity_id = activity_id
          ss.save
        else
          is_subscribed = false
          raise Sequel::Rollback
        end
      end
    end
    is_subscribed
  end
end
