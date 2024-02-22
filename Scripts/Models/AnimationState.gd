class_name AnimationState

var name : String
var frame : int
var amountFrames : int
var isPlayable : bool

func _init(n : String = "", f : int = 0, aFrames : int = 0, isP : bool = false):
	name = n
	frame = f
	amountFrames = aFrames
	isPlayable = isP
	
