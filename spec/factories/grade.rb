FactoryGirl.define do
    factory :grade do
        mark 5
        association :user
        association :recipe
    end
end