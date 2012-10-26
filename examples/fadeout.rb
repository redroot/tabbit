require File.expand_path(File.join(File.dirname(__FILE__), *%w[.. lib tabbit]))

PARSER = Tabbit::Parser.new do |p|
  p.instrument = Tabbit::Instruments::Guitar.new("Mustang Sally")
  p.player = Tabbit::Players::Micromidi.new()
end

notes = []

part_1 = %{
e|-----0-------0-------0----------
B|---------3-------1-------0------
G|-------2---2---2---2---2---2---2
D|---2-------------------------2--
A|-0------------------------------
E|--------------------------------
}

part_2 = %{
e|-----0-------0-------0----------
B|---------3-------1-------0------
G|-------0---0---0---0---0---0---0
D|-----------------------------2--
A|---2----------------------------
E|-0------------------------------
}

part_3 = %{                       
e|-----0-------0-------0----------
B|---------3-------1-------0------
G|-------0---0---0---0---0---0---0
D|---2-------------------------2--
A|-3------------------------------
E|--------------------------------
}

part_4 = %{
e|-----0---------
B|---------3-1-1-
G|-------2---2-2-
D|---2-------2-2-
A|-0---------0-0-
E|---------------
}

2.times { notes.push(PARSER.parse(part_1)) }
2.times { notes.push(PARSER.parse(part_2)) }
2.times { notes.push(PARSER.parse(part_1)) }
1.times { notes.push(PARSER.parse(part_3)) }
1.times { notes.push(PARSER.parse(part_2)) }
1.times { notes.push(PARSER.parse(part_1)) }
1.times { notes.push(PARSER.parse(part_4)) }

notes.flatten!(1)

PARSER.player.play(notes,0.1)