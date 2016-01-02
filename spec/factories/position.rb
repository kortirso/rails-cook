FactoryGirl.define do
    factory :position do
        association :recipe
        association :cart
    end
end