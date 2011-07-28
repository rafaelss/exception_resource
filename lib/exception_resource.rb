require "exception_resource/version"
require "exception-hashify"

module ExceptionResource
  def self.site=(value)
    @site = value
  end

  def self.site
    @site
  end

  module Base
    def save
      url = URI.parse(ExceptionResource.site) rescue nil
      return false unless url

      url.path = "/" if url.path.empty?
      url.path += "exceptions"

      if url
        response = nil
        Net::HTTP.start(url.host, url.port) do |request|
          response = request.post(url.request_uri, to_hash.map { |k, v| "#{k}=#{v}" }.join("&"))
        end
        response.code == "201"
      else
        false
      end
    end

    def save!
      save
      raise self
    end
  end
end

Exception.send(:include, ExceptionResource::Base)

