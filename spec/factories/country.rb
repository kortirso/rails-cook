FactoryGirl.define do
    factory :country do
        name 'test_country'
        caption 'test country'
    end
    factory :invalid_country, class: Country do
        name nil
        caption nil
    end
end