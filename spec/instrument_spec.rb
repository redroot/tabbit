require 'spec_helper'
require 'tabbit/instrument'
require 'tabbit/instruments'

describe Tabbit::Instrument do
  
  before :each do
    @instrument = Tabbit::Instrument.new("Luke's Guitar")
  end
  
  it "should keep its name" do
    @instrument.respond_to?(:name).should eql(true)
    @instrument.name.should eql("Luke's Guitar")
  end

  it "should allow me to set any number of strings with a method" do
    @instrument.string 1, "E2"
    @instrument.string 2, "A2"
    @instrument.string 3, "D3"
    
    expected = {
      1 => "E2",
      2 => "A2",
      3 => "D3"
    }
    
    @instrument.strings.should eql(expected)
  end
  
  it "should allow me to see the strings" do
    @instrument.respond_to?(:strings).should eql(true)
  end
  
  it "should allow me to retune once with a block" do
    @instrument.string 1, "E2"
    @instrument.string 2, "A2"
    @instrument.string 3, "D3"
    
    @instrument.retune do |i|
      i.string 1, "D2"
    end
    
    expected = {
      1 => "D2",
      2 => "A2",
      3 => "D3"
    }
    
    @instrument.strings.should eql(expected)
  end
  
  it "should allow me to retune with a tuning" do
    @instrument.string 1, "E2"
    @instrument.string 2, "A2"
    @instrument.string 3, "D3"
    @instrument.string 4, "G3"
    @instrument.string 5, "B3"
    @instrument.string 6, "E4"
    
    expected = {
      1 => "D2",
      2 => "A2",
      3 => "D3",
      4 => "G3",
      5 => "A3",
      6 => "D4"
    }
    
    @instrument.retune(:drop_d)
    
    @instrument.strings.should eql(expected)
  end
  
  it "should allow me to drop all strings by an amount" do
    @instrument.string 1, "E2"
    @instrument.string 2, "A2"
    @instrument.string 3, "D3"
    @instrument.string 4, "G3"
    @instrument.string 5, "B3"
    @instrument.string 6, "E4"
    
    @instrument.retune_all_strings(-2)
    
    expected = {
      1 => "D2",
      2 => "G2",
      3 => "C3",
      4 => "F3",
      5 => "A3",
      6 => "D4"
    }
    
    
    @instrument.strings.should eql(expected)
  end
  
  it "should allow me to play a note on each string" do
    @instrument.string 1, "E2"
    @instrument.string 2, "A2"
    @instrument.string 3, "D3"
    
    @instrument.note(1,5).should eql("A2")
    @instrument.note(2,8).should eql("F3")
    @instrument.note(3,6).should eql("G#3")
  end
  
end

describe Tabbit::Instruments::Bass do
  
  before(:each) { @bass = Tabbit::Instruments::Bass.new("Bass") }
  
  it "should have 4 strings" do
    @bass.strings.length.should eql(4)
  end
  
  it "should have to correct default tuning" do
    expected = {
      1 => "E1",
      2 => "A1",
      3 => "D2",
      4 => "G2"
    }
    @bass.strings.should eql(expected)
  end
  
  
  it "should retune to drop d properly " do
    expected = {
      1 => "D1",
      2 => "A1",
      3 => "D2",
      4 => "G2"
    }
    @bass.retune(:drop_d)
    @bass.strings.should eql(expected)
  end
  
  it "should do the following notes correctly do" do
    @bass.note(1,5).should eql("A1")
    @bass.note(2,8).should eql("F2")
    @bass.note(3,6).should eql("G#2")
  end
  
end

describe Tabbit::Instruments::Guitar do
  
  before(:each) { @guitar = Tabbit::Instruments::Guitar.new("Guitar") }
  
  it "should have 6 strings" do
    @guitar.strings.length.should eql(6)
  end
  
  it "should have to correct default tuning" do
    expected = {
      1 => "E2",
      2 => "A2",
      3 => "D3",
      4 => "G3",
      5 => "B3",
      6 => "E4"
    }
    @guitar.strings.should eql(expected)
  end
  
  it "should retune to drop d properly " do
    expected = {
      1 => "D2",
      2 => "A2",
      3 => "D3",
      4 => "G3",
      5 => "A3",
      6 => "D4"
    }
    @guitar.retune(:drop_d)
    @guitar.strings.should eql(expected)
  end
  
  it "should do the following notes correctly do" do
    @guitar.note(1,5).should eql("A2")
    @guitar.note(2,8).should eql("F3")
    @guitar.note(3,6).should eql("G#3")
  end

  
end