require "exception_resource/version"
require "exception-hashify"
require "addressable/uri"

module ExceptionResource
  def self.site=(value)
    @site = value
  end

  def self.site
    @site
  end

  def self.create(exception)
    url = Addressable::URI.parse(site)
    return false unless url

    url.path = "/" if url.path.empty?
    url.path += "exceptions"

    response = nil
    Net::HTTP.start(url.host, url.port) do |request|
      response = request.post(url.request_uri, exception.to_hash.map { |k, v| "#{k}=#{v}" }.join("&"))
    end
    response.code == "201"
  end

  def self.create!(exception)
    create(exception)
    raise exception
  end
end

