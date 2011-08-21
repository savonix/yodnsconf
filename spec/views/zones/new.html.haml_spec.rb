require 'spec_helper'

describe "zones/new.html.haml" do

  it "Renders new zone form" do
    assign(:zone, Zone.new)
    render
    rendered.should =~ /Create/
  end 

end
