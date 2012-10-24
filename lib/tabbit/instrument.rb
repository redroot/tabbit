require 'tabbit/notes'
module Tabbit
  class Instrument
    include Tabbit::Notes
    
    attr_accessor :name
    attr_accessor :strings
    
    # tunings of modifications of normal guitar tunings
    TUNINGS = {
      :drop_d => [-2,0,0,0,-2,-2]
    }
    
    def initialize(name, &blk)
      @name    = name
      @strings = {}
      yield self if blk
    end
    
    def string(pos,note)
      @strings[pos] = note
    end
    
    def note(string,fret)
      transpose(@strings[string],fret)
    end
    
    def retune(tuning=nil, &blk)
      if tuning and TUNINGS.has_key?(tuning)
        steps = TUNINGS[tuning]
        @strings.each_with_index do |(string,note),index|
          @strings[string] = transpose(note,steps[index])
        end
      end
      yield self if blk
    end
    
    def retune_all_strings(steps)
      @strings.each { |string,note| @strings[string] = transpose(note,steps) }
    end
    
  end
end