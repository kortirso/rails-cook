FactoryGirl.define do
    factory :product do
        association :ingridient
        association :basket
        association :measure
    end
end