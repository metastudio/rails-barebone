# frozen_string_literal: true

module Emailable
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true, uniqueness: true, email: { mode: :strict, require_fqdn: true }, length: { in: 5..255 }
  end
end
