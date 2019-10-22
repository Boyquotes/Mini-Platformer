#LevelNumber.gd
extends Label

export(String, FILE, ".txt") var world_number

func _ready():
	text = "LEVEL" + world_number

