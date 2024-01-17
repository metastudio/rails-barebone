class BaseService
  class ServiceResponse
    attr_reader :status, :payload

    def initialize(status, payload = nil)
      @status   = status
      @payload  = payload
    end

    def success?
      status == :ok
    end

    def error
      payload if status == :error
    end
  end

  def self.perform(*)
    new(*).perform
  end

  def perform
    raise NotImplementedError
  end

  def ok(payload = nil)
    ServiceResponse.new(:ok, payload)
  end

  def error(errors = {})
    ServiceResponse.new(:error, errors)
  end
end
