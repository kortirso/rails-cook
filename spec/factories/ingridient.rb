FactoryGirl.define do
    factory :ingridient do
        sequence(:name) { |i| "simple ingredient #{i}" }
    end
    factory :invalid_ingridient, class: Ingridient do
        name nil
    end
end