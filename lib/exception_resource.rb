require "exception_resource/version"
require "exception-hashify"
require "addressable/uri"
require "net/http"

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
      response = request.post(url.request_uri, to_query(exception))
    end
    response.code == "201"
  end

  def self.create!(exception)
    create(exception)
    raise exception
  end

  protected

  def self.to_query(exception)
    uri = Addressable::URI.new
    uri.query_values = exception.to_hash
    uri.query
  end
end

