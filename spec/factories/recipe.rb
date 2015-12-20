FactoryGirl.define do
    factory :recipe do
        name "Test recipe"
        prepare 60
        portions 4
        association :category
        association :user
    end
end