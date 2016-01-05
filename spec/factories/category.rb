FactoryGirl.define do
    factory :category do
        name 'test_snacks'
        caption 'test snacks'
    end
    factory :invalid_category, class: Category do
        name nil
        caption nil
    end
end