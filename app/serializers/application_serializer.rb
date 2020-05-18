# frozen_string_literal: true

# Base application Serializer
class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  include UrlHelpers
end
