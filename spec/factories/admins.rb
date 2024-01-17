# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  sequence(:admin_password) { "Aa#{SecureRandom.hex(6)}!" }
  sequence(:admin_email) { |n| "admin#{n}@example.com" }

  factory :admin do
    email { generate(:admin_email) }
    password { generate(:admin_password) }
  end
end
