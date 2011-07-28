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
      url = URI.parse(ExceptionResource.site).merge("/exceptions") rescue nil
      if url
        response = Net::HTTP.post_form(url, to_hash)
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

