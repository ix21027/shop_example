FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "users first name #{n}" }
    sequence(:last_name)  { |n| "users last name #{n}"  }

    password { 'password' }

    email { first_name.gsub(" ", "_") + "@example.com" }

    after :create do |user|
      create :session, user: user
      create_list :product, 3
      create :store
      create :order,   user: user
    end
  end

  factory :session do
  end

  factory :order do
    user
    after :create do |order|
      create_list :line_item, 3, order: order
    end
  end

  factory :line_item do
    order
    product
    sequence(:quantity)
  end

  factory :store do
    sequence(:priority)
    sequence(:name) { |n| "Store #{n}" }

    after :create do |store|
      create_list :available, 3, store: store
    end
  end

  factory :available do
    sequence(:quantity)
    product
  end

  factory :product do
    sequence(:name) { |n| "product #{n}" }
    sequence(:price)
  end
end