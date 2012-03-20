require 'spec_helper'

describe Talk do
  it "has a title and duration" do
    t = Talk.new(title: "Debugging with Pry", duration: 10)
    t.valid?.should be_true
  end
end
