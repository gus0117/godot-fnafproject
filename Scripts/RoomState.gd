class_name RoomState

var roomName : String   # The room name
var cam : String        # CamName
var animation: String   # Animation Name
var frame : int         # Current frame
var isEmpty : bool      # Set if some character is in this room

# Constructor
func _init(room: String = "", c: String = "", a: String = "", f: int = 0, empty: bool = true):
	roomName = room
	cam = c
	animation = a
	frame = f
	isEmpty = empty
