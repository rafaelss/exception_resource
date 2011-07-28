class SiteWithQueryStringApp < ExceptionApp

  def call(env)
    request = Rack::Request.new(env)
    unless request.params["token"]
      env = {}
    end
    super(env)
  end
end

