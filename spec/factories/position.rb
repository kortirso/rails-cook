FactoryGirl.define do
    factory :position do
        quantity 1
        association :recipe
        association :cart
    end
end