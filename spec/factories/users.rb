# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint
#  invitations_count      :integer          default(0)
#  deactivated_at         :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  sequence(:user_password)   { "Aa#{SecureRandom.hex(6)}!" }
  sequence(:user_email)      { |n| "user#{n}@example.com" }
  sequence(:user_first_name) { |n| "First Name #{n}" }
  sequence(:user_last_name)  { |n| "Last Name #{n}" }
  sequence(:user_phone)      { "3175083#{rand(100..999)}" }

  factory :user do
    email      { generate(:user_email) }
    password   { generate(:user_password) }
    first_name { generate(:user_first_name) }
    last_name  { generate(:user_last_name) }
    phone      { generate(:user_phone) }
  end
end
