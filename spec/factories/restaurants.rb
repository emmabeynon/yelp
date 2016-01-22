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

  factory :image do
    file { fixture_file_upload 'test.jpg', 'image/jpg' }
  end

  factory :user do
    trait :first do
      email 'jane@test.com'
      password 'janedoee'
      password_confirmation 'janedoee'
    end

    trait :second do
      email 'john@doe.com'
      password 'johndoee'
      password_confirmation 'johndoee'
    end
  end
end
