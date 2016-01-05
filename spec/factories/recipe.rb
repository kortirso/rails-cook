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
        crockpot false
        healthfood false
        association :category
        association :user

        trait :visible do
            visible true
        end

        trait :invalid do
            name nil
        end
    end
end