require 'spec_helper'

describe "zones/index.html.haml" do

  it "Renders zone index" do
    assign(:zones, [stub_model(Zone)])
    render
    rendered.should =~ /Zones/
  end 

end
