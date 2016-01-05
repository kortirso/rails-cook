FactoryGirl.define do
    factory :measure do
        name 'гр'

        trait :invalid do
            name nil
        end
    end
end