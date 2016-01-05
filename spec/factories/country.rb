FactoryGirl.define do
    factory :country do
        name 'test_country'
        caption 'test country'

        trait :invalid do
            name nil
            caption nil
        end
    end
end