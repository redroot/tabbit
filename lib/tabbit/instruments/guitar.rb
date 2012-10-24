module Tabbit
  module Instruments
    class Guitar < Tabbit::Instrument
      def initialize(name)
        super(name)
        
        string 1, "E2"
        string 2, "A2"
        string 3, "D3"
        string 4, "G3"
        string 5, "B3"
        string 6, "E4"
      end
    end
  end
end