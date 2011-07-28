class ExceptionApp

  def call(env)
    request = Rack::Request.new(env)
    response = if request.post? && request.host == "localhost" && request.path_info =~ /^\/exceptions/
      if request.params["class_name"] && request.params["message"] && request.params["backtrace"]
        [ 201, { "Content-Type" => "application/json" }, [ "OK" ]]
      end
    end

    response ||= [ 406, { "Content-Type" => "application/json" }, [ "Not Acceptable" ]]
    response
  end
end

