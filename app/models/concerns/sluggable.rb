module Sluggable
  extend ActiveSupport::Concern

  included do
    include FriendlyId

    friendly_id :slug

    validates :slug, uniqueness: true
    validates :slug, presence: true, format: { with: /\A[0-9a-zA-Z\-]*\z/ }

    before_validation :set_slug, if: -> { slug.blank? }

    def set_slug
      self.slug =
        if has_attribute?(:name) && name.present?
          name.parameterize
        else
          "slug-#{SecureRandom.alphanumeric.downcase}"
        end
    end
  end
end
