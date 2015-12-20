FactoryGirl.define do
    factory :recipe do
        name 'test recipe'
        short 'test_recipe'
        caption 'test recipe caption'
        visible false
        path_name 'test_recipe'
        prepare 10
        portions 4
        stars 0
        marks 0
        average 0
        views 0
        association :category
        association :country
        association :user

        trait :visible do
            visible true
        end
    end
end