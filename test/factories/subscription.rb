Factory.define :subscription do |subscription|
  subscription.expires_on { Date.today + 30.days }
end
