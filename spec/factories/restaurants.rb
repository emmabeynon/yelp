FactoryGirl.define do
  factory :restaurant do
    trait :first do
      name 'kfc'
    end

    trait :second do
      name 'mcdonalds'
    end

    trait :too_short do
      name 'kf'
    end
  end
end
