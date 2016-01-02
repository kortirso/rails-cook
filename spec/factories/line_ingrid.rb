FactoryGirl.define do
    factory :line_ingrid do
        association :ingridient
        association :recipe
        association :measure
    end
end