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
ActiveAdmin.register User do
  menu parent: ['User Administration']

  actions :all

  config.clear_action_items!

  permit_params :email, :first_name, :last_name, :phone, :company

  # action_item only: :index do
  #   link_to 'Invite User', new_admin_user_path
  # end

  member_action :reinvite, method: :patch do
    resource.invite!
    redirect_to admin_user_path(resource), notice: I18n.t("devise.invitations.send_instructions", email: resource.email)
  end

  member_action :activate, method: :patch do
    resource.activate
    redirect_to admin_user_path(resource), notice: I18n.t("devise.activations.activate", email: resource.email)
  end

  member_action :deactivate, method: :patch do
    resource.deactivate
    redirect_to admin_user_path(resource), notice: I18n.t("devise.activations.deactivate", email: resource.email)
  end

  controller do
    # rubocop:disable Metrics/AbcSize
    def create
      build_resource

      resource.valid?
      if resource.errors.messages.except(:password).blank?
        resource.invite!(current_admin)
        redirect_to admin_user_path(resource), notice: I18n.t("devise.invitations.send_instructions", email: resource.email)
      else
        super
      end
    end
    # rubocop:enable Metrics/AbcSize
  end

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :phone
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
  end

  filter :email
  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :phone
    end
    f.actions
  end
end
