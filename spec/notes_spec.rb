require 'spec_helper'
require 'tabbit/notes'

describe Tabbit::Notes do
  
   before :each do
     @dummy = Class.new
     @dummy.extend(Tabbit::Notes) 
   end
   
   it "should return true if a note exists" do
     @dummy.is_note?("B2").should eql(true)
     @dummy.is_note?("E4").should eql(true)
   end
   
   it "should extract note information" do
     @dummy.extract_note("B2").should eql(["B","2"])
     @dummy.extract_note("C#4").should eql(["C#","4"])
     @dummy.extract_note("Eb-1").should eql(["Eb","-1"])
   end
   
   it "should resolve flats and sharps we dont have" do
     @dummy.resolve("D#2").should eql("Eb2")
     @dummy.resolve("Gb0").should eql("F#0")
     @dummy.resolve("Ab0").should eql("G#0")
   end
   
   it "should find flats and sharps we don't have" do
     @dummy.is_note?("Gb0").should eql(true)
     @dummy.is_note?("Ab0").should eql(true)
     @dummy.is_note?("B0").should eql(true)
   end
   
   it "should return false for non notes" do
     @dummy.is_note?(Integer).should eql(false)
     @dummy.is_note?("asdasads").should eql(false)
     @dummy.is_note?("H1").should eql(false)
   end
   
   it "should allow transposing a number of steps" do
     @dummy.transpose("E1",2).should eql("F#1")
     @dummy.transpose("E1",12).should eql("E2")
     @dummy.transpose("C#3",7).should eql("G#3")
   end
   
   it "should allow me to modify the octave of a note" do
     @dummy.octave("C3",1).should eql("C4")
     @dummy.octave("Bb4",-2).should eql("Bb2")
   end
   
   it "should allow me to flatten or sharpen a note" do
     @dummy.flatten("C#2").should eql("C2")
     @dummy.sharpen("B5").should eql("C6")
   end
   
   it "should give me back a chord for a specific root note" do
     @dummy.chord("C3",:major).should eql(%w[C3 G3 C4 E4])
   end
   
   it "should let me get variations of chords, major, minor, and 7ths" do
     @dummy.chord("E3",:minor).should eql(%w[E3 B3 E4 G4])
     @dummy.chord("E3",:seven).should eql(%w[E3 B3 D4 G#4])
     @dummy.chord("E3",:major_seven).should eql(%w[E3 B3 Eb4 G#4])
     @dummy.chord("E3",:minor_seven).should eql(%w[E3 B3 D4 G4])
   end
   
   it "should give me a cool scale" do
     @dummy.scale("E2",:major).should eql(%w[E2 F#2 G#2 A2 B2 C#3 Eb3 E3])
     @dummy.scale("E2",:minor).should eql(%w[E2 F#2 G2 A2 B2 C3 D3 E3])
   end
  
end