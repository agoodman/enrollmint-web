Factory.define :subscription do |subscription|
  subscription.expires_on { Time.now + 1.month }
end
