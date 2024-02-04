extends Node

#GLOBAL VARS
var currentHour : int = 12

#REFERENCES
@export var monitorScene : PackedScene = preload("res://Scenes/monitor_scene.tscn")
@export var officeScene : PackedScene = preload("res://Scenes/office.tscn")

func SwitchToMonitor() -> void:
	get_tree().change_scene_to_packed(monitorScene)

func SwitchToOffice() -> void:
	get_tree().change_scene_to_packed(officeScene)
	#officeScene.AnimateMonitor()

func SetNextHour() -> void:
	if currentHour == 12:
		currentHour = 1
	else:
		currentHour += 1
		if currentHour == 6:
			print("Finish")

func GetHourString() -> String:
	return str(currentHour)+":00AM"
