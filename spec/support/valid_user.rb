Factory.define :valid_user, :class => User do |u|
  u.email "user@example.com"
  u.password "password"
  u.password_confirmation "password"
end
