FactoryBot.define do
  factory :user do

    email { Faker::Internet.email }
    name { Faker::Name.unique.name }
    password { Faker::Internet.password }
    role { :user }

    # Generar un trait por cada rol existente en el sistema
    User.roles.keys.each do |k|    
      trait :"#{k}" do
        role { :"#{k}" }
      end
    end
  end
end
