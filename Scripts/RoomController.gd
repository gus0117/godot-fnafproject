class_name RoomController

extends AnimatedSprite2D

var roomState : RoomState

func SetRoomState(rs : RoomState) -> void :
	roomState = RoomState.new(rs.roomName, rs.cam, rs.animation, rs.frame, rs.isEmpty)

func SwitchFrame(f: int) -> void:
	frame = f

func ResetFrame() -> void:
	frame = 0
