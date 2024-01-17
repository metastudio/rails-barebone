module PasswordValidatable
  extend ActiveSupport::Concern

  included do
    validate :password_complexity

    private

    def password_complexity
      return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

      errors.add(
        :password,
        'must include at least one lowercase letter, one uppercase letter, one digit and one special character'
      )
    end
  end
end
