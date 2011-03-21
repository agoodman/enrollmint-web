Factory.define :product do |product|
  product.identifier  { "identifier" }
  product.duration    { 1.month }
  product.price       { 0.99 }
end
