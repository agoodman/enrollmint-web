Factory.sequence :identifier do |n|
  "com.product.identifier.#{n}"
end

Factory.define :product do |product|
  product.identifier  { Factory.next :identifier }
  product.duration    { 1.month }
  product.price       { 0.99 }
end
