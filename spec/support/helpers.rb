module Helpers

  def with_exception
    begin
      raise "teste"
    rescue => ex
      yield ex
    end
  end
end

