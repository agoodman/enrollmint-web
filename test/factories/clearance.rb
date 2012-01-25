Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.password              { "password" }
  user.first_name           { "first" }
  user.last_name            { "last" }
  user.terms_of_service_accepted  { true }
end

Factory.define :email_confirmed_user, :parent => :user do |user|
  user.after_build { warn "[DEPRECATION] The :email_confirmed_user factory is deprecated, please use the :user factory instead." }
end
