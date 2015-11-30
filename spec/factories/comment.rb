FactoryGirl.define do
    factory :comment do
        body 'random comment'
        association :user
        association :recipe
    end
end