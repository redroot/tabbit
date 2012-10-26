require "midi"

module Tabbit
  module Players
    class Micromidi 

      def play(notes,duration)
        o = UniMIDI::Output.open(:first)
        MIDI.using(o) do
          notes.each do |note|
            play note, duration
          end
        end
      end
    
    end
  end
end


