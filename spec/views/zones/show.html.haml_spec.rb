require 'spec_helper'

describe "zones/show.html.haml" do

  it "Renders zone" do
    assign(:zone, stub_model(Zone))
    render
    rendered.should =~ /Edit/
  end 

end
