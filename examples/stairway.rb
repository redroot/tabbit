require File.expand_path(File.join(File.dirname(__FILE__), *%w[.. lib tabbit]))

parser = Tabbit::Parser.new do |p|
  p.instrument = Tabbit::Instruments::Guitar.new("Mustang Sally")
  p.player = Tabbit::Players::Micromidi.new()
end

tab = %{
e|-5-----5-7-----7-8-----8-2-----2-0-----0-------------------------
B|---5-------5-------5-------3-------1-----1------0-0-1-1-1--------
G|-----5-------5-------5-------2-------2-----2---------------------
D|-7-----7-6-----6-5-------4-----4-3-----3-----3-------------------
A|------------------------------------------------2-2-0-0-0--------
E|-----------------------------------------------------------------
}

parser.parse(tab)
parser.play