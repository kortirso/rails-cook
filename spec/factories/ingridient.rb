FactoryGirl.define do
    factory :ingridient do
        sequence(:name) { |i| "simple ingredient #{i}" }

        trait :invalid do
            name nil
        end
    end
end