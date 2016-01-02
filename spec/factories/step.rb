FactoryGirl.define do
    factory :step do
        text 'simple step'
        association :recipe
    end
end