FactoryGirl.define do
    factory :comment do
        body 'random comment'
        association :user
        association :recipe

        trait :invalid do
            body nil
        end
    end
end