Factory.define :subscription do |subscription|
  subscription.product_identifier { "com.migrant.product.id" }
  subscription.expires_on { Date.today + 30.days }
end
