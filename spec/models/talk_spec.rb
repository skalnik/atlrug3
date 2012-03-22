require 'spec_helper'

describe Talk do
  let(:talk) { build(:talk) }
  subject    { talk }

  context "validations" do
    it "validates presence of title" do
      talk.title = ""
      should_not be_valid
    end

    it "validates presence of description" do
      talk.description = ""
      should_not be_valid
    end

    it "validates presence of duration" do
      talk.duration = ""
      should_not be_valid
    end

    it "validates numericality of duration" do
      talk.duration = "NaN"
      should_not be_valid
    end

    it "validates postivity of duration" do
      talk.duration = -1
      should_not be_valid
    end

    it "validates duration is an integer" do
      talk.duration = 1.5
      should_not be_valid
    end

    it "validates presence of email" do
      talk.email = ""
      should_not be_valid
    end

    it "validates format of email" do
      talk.email = "invalid email!"
      should_not be_valid
    end

    it "validates format of email" do
      talk.email = "invalid email!"
      should_not be_valid
    end
  end
end
