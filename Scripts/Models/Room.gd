class_name Room

var name : String
var camName : String
var animation : AnimationState
var isEmpty : bool

func _init(n: String = "", cam: String = "", anim : AnimationState = AnimationState.new(), emp : bool = true):
	name = n
	camName = cam
	animation = AnimationState.new(anim.name, anim.amountFrames, anim.isPlayable)
	isEmpty = emp
