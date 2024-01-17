class Credentials
  class << self
    def get(*keys)
      keys.reduce(credentials) { |creds, key| creds.fetch(key) }
    end

    private

    def credentials
      Rails.application.credentials
    end
  end
end
