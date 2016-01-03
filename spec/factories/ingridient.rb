FactoryGirl.define do
    factory :ingridient do
        sequence(:name) { |i| "simple ingredient #{i}" }
    end
end