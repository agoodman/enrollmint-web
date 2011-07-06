Factory.define :subscription do |subscription|
  subscription.expiration_date { Time.now + 1.month }
end
