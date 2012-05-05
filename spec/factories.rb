FactoryGirl.define do
  factory :user do
    name     "Josh van Tonder"
    email    "joshvt@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end