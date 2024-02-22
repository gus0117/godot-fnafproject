class_name AnimationState

var name : String
var amountFrames : int
var isPlayable : bool

func _init(n : String = "", aFrames : int = 0, isP : bool = false):
	name = n
	amountFrames = aFrames
	isPlayable = isP
	
