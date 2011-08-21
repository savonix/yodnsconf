require 'spec_helper'

describe "zones/edit.html.haml" do

  it "Renders zone edit form" do
    assign(:zone, stub_model(Zone))
    render
    rendered.should =~ /Edit/
  end 

end
