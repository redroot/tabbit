module Tabbit
  module Instruments
    class Bass < Tabbit::Instrument
      def initialize(name)
        super(name)
        
        string 1, "E1"
        string 2, "A1"
        string 3, "D2"
        string 4, "G2"
      end
    end
  end
end