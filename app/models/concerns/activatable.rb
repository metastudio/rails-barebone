module Activatable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deactivated_at: nil) }

    def active?
      deactivated_at.blank?
    end

    def deactivated?
      deactivated_at.present?
    end

    def activate
      update(deactivated_at: nil)
    end

    def deactivate
      update(deactivated_at: Time.current)
    end

    def active_for_authentication?
      super && active?
    end
  end
end
