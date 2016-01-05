FactoryGirl.define do
    factory :category do
        name 'test_snacks'
        caption 'test snacks'

        trait :invalid do
            name nil
            caption nil
        end
    end
end