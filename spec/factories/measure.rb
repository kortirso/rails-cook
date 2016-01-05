FactoryGirl.define do
    factory :measure do
        name 'гр'
    end
    factory :invalid_measure, class: Measure do
        name nil
    end
end