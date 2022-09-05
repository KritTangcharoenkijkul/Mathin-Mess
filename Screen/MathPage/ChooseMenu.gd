extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Global.MultiplicationRound = 20
	get_tree().change_scene("res://Screen/MathPage/Calculate.tscn")


func _on_Button2_pressed():
	Global.MultiplicationRound = 10
	get_tree().change_scene("res://Screen/MathPage/Calculate.tscn")


func _on_Button3_pressed():
	Global.MultiplicationRound = 100
	get_tree().change_scene("res://Screen/MathPage/Calculate.tscn")
