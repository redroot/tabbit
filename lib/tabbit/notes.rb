module Tabbit
  module Notes  
    NOTES = [
      "C-1", "C#-1", "D-1", "Eb-1", "E-1", "F-1", "F#-1", "G-1", "G#-1", "A-1", "Bb-1", "B-1", 
      "C0", "C#0", "D0", "Eb0", "E0", "F0", "F#0", "G0", "G#0", "A0", "Bb0", "B0", 
      "C1", "C#1", "D1", "Eb1", "E1", "F1", "F#1", "G1", "G#1", "A1", "Bb1", "B1", 
      "C2", "C#2", "D2", "Eb2", "E2", "F2", "F#2", "G2", "G#2", "A2", "Bb2", "B2", 
      "C3", "C#3", "D3", "Eb3", "E3", "F3", "F#3", "G3", "G#3", "A3", "Bb3", "B3", 
      "C4", "C#4", "D4", "Eb4", "E4", "F4", "F#4", "G4", "G#4", "A4", "Bb4", "B4", 
      "C5", "C#5", "D5", "Eb5", "E5", "F5", "F#5", "G5", "G#5", "A5", "Bb5", "B5", 
      "C6", "C#6", "D6", "Eb6", "E6", "F6", "F#6", "G6", "G#6", "A6", "Bb6", "B6", 
      "C7", "C#7", "D7", "Eb7", "E7", "F7", "F#7", "G7", "G#7", "A7", "Bb7", "B7", 
      "C8", "C#8", "D8", "Eb8", "E8", "F8", "F#8", "G8", "G#8", "A8", "Bb8", "B8", 
      "C9", "C#9", "D9", "Eb9", "E9", "F9", "F#9", "G9", "G#9", "A9", "Bb9", "B9"
    ]
    
    SPECIAL = {
      "Db" => "C#",
      "D#" => "Eb",
      "Gb" => "F#",
      "Ab" => "G#"
    }
    
    CHORDS = {
      :major        => [0,7,12,16],
      :minor        => [0,7,12,15],
      :seven        => [0,7,10,16],
      :major_seven  => [0,7,11,16],
      :minor_seven  => [0,7,10,15]
    }
    
    SCALES = {
      :major => [0,2,4,5,7,9,11,12],
      :minor => [0,2,3,5,7,8,10,12]
    }

    def is_note?(note)
      return false unless note.is_a?(String) and note.length <= 4
      return true if NOTES.include?(note)
      NOTES.include?(resolve(note))
    end

    def resolve(root)
      note, octave = extract_note(root)
      return root unless SPECIAL.has_key?(note)
      SPECIAL[note] + octave
    end

    def transpose(root,steps)
      return unless is_note?(root)
      return root if steps == 0 
      NOTES[NOTES.index(root) + steps] || nil
    end
    
    def octave(root,step)
      transpose(root, step * 12)
    end
    
    def flatten(root)
      transpose(root, -1)
    end
    
    def sharpen(root)
      transpose(root, 1)
    end
    
    def chord(root,chord)
      return false unless CHORDS.has_key?(chord)
      CHORDS[chord].map { |s| transpose(root,s) }
    end
    
    def scale(root,scale)
      return false unless SCALES.has_key?(scale)
      SCALES[scale].map { |s| transpose(root,s) }
    end
    
    def extract_note(root)
      note = root.match(/[bA-Z\#]+/)[0]
      octave = root.delete(note)
      [note,octave]
    end
    
  end
end