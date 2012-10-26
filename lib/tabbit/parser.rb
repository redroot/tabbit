module Tabbit
  class Parser
    attr_accessor :instrument
    attr_accessor :player
    
    DURATION = 0.20
    
    def initialize(&blk)
      yield self if blk
    end
    
    def parse(str)
      @tracks = str.split("\n")
      @tracks.reject! { |s| s.length < 2 }.respond_to?(:map!) # reject any non lines
      @tracks.map! do |track|
        track.gsub!(/[A-Za-z\|]+/,"")           # remove letters from the start and bars
        track.gsub!(/(?<!\d)(?=\d(?!\d))/,"0")  # single digits get tens, -2- to -02-
        track
      end.reverse! # reverse the order, string 1 to 6

      # process the result
      process_tracks
      # now process the individual beats into something we can play 
      process_beats
      # return notes
      @notes
    end
    
    def play(duration=nil)
      raise "Please set a player" unless @player
      puts "Playing #{@notes.length} of duration #{DURATION}"
      puts "Instrument: #{@instrument.name} | #{@instrument.class.name}"
      puts "Player: #{@player.class.name}"
      @player.play(@notes, duration || DURATION)
    end
    
    private
    
    def process_tracks
      size = @tracks.length
      pos = 0
      @beats = []
      while @tracks.all? { |t| t[pos] }
        beat = []
        @tracks.each do |track|
          has_number = track[pos].match(/[0-9]+/)
          if has_number.nil?
            beat.push nil
          elsif has_number.respond_to?(:length)
            # we have a number so we need to grab the pos immediate afterards
            beat.push(track[pos] + track[pos+1])
            # now we have to delete track pos + 1
            track.slice!(pos+1) 
          end
          track[pos] = "#" #we are done here
        end
        @beats.push(beat)
        pos += 1
      end
    end
    
    def process_beats
      raise "There must an Tabbit::Instrument as the @instrument" unless @instrument and @instrument.respond_to?(:note)
      @notes = []
      @beats.each do |beat| 
        beat.each_with_index do |n,index|
          if n.is_a?(String) and @instrument.strings[index+1]
            beat[index] = @instrument.note(index+1,n.to_i)
          else
            beat[index] = nil
          end
        end
        @notes.push(beat.compact!)
      end
    end
    
  end
end