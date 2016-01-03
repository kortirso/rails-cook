FactoryGirl.define do
    factory :line_ingrid do
        quantity 1
        association :ingridient
        association :recipe
        association :measure
    end
end