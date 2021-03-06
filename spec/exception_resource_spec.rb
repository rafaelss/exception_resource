require "spec_helper"

describe ExceptionResource do
  before :each do
    ExceptionResource.site = "http://localhost:3000"
  end

  it "should send the exception to configured url" do
    with_exception do |ex|
      Artifice.activate_with(ExceptionApp.new) do
        ExceptionResource.create(ex).should == true
      end
    end
  end

  it "should re-raise the exception" do
    ExceptionResource.site = "http://google.com"

    with_exception do |ex|
      Artifice.activate_with(ExceptionApp.new) do
        lambda { ExceptionResource.create!(ex) }.should raise_error(ex)
      end
    end
  end

  it "should do nothing if site is not configured or invalid" do
    ExceptionResource.site = nil
    Net::HTTP.should_receive(:post_form).never

    with_exception do |ex|
      ExceptionResource.create(ex).should == false
    end
  end

  it "should merge site url with pre-defined path" do
    ExceptionResource.site = "http://localhost:3000?token=123456789"

    with_exception do |ex|
      Artifice.activate_with(SiteWithQueryStringApp.new) do
        ExceptionResource.create(ex).should == true
      end
    end
  end
end

