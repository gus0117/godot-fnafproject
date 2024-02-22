class_name Enemy

var name: String
var pos: Room

func _init(n : String = "", p: Room = Room.new()):
	name = n
	pos = Room.new(p.name, p.camName, p.animation)
