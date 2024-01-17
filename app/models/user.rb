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
class User < ApplicationRecord
  include Activatable
  include PasswordValidatable
  include Emailable
  include Phoneable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, email: true
  validates :email, uniqueness: true
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :first_name, presence: true, on: :update

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      created_at
      deactivated_at
      email
      first_name
      id
      last_name
      phone
      updated_at
    ]
  end

  def send_devise_notification(notification, *)
    devise_mailer.send(notification, self, *).deliver_later
  end

  def name
    return first_name if last_name.blank?

    "#{first_name} #{last_name}"
  end

  def status
    return 'Deactivated' if deactivated_at.present?
    return 'Invited' if invitation_token.present? && !invitation_accepted?
    return 'Active' if invitation_accepted?

    'Inactive'
  end
end
