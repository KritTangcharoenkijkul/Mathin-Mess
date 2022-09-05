extends Node2D


var a = 0
var b = 0
var c = 0
var seta = []
var setb = []
var hand = []
var answer = []
var currquestion = 0
var time_elapsed := 0.0
var fintime 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta: float) -> void:
	time_elapsed += delta
	$Time.text = str(time_elapsed)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(Global.MultiplicationRound):
		a = randi() % 10
		b = randi() % 10
		
		if(a > b):
			c = randi() % 3 # 0 = +, 1 = *, 2 = -
		else:
			c = randi() % 2  # 0 = +, 1 = *,
		
		seta.append(a)
		setb.append(b)
		hand.append(c)
		match c:
			0:
				answer.append(a+b)
			1:
				answer.append(a*b)
			2:
				answer.append(a-b)
		
		
	print(seta)
	print(setb)
	print(hand)
	print(answer)
	$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineEdit.grab_focus()
	
	match hand[currquestion]:
			0:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "+" + str(setb[currquestion]) + "=")
			1:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "x" + str(setb[currquestion]) + "=")
			2:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "-" + str(setb[currquestion]) + "=")
	
	match hand[currquestion+1]:
			0:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "+" + str(setb[currquestion+1]) + "=")
			1:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "x" + str(setb[currquestion+1]) + "=")
			2:
				$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "-" + str(setb[currquestion+1]) + "=")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func changequestion():
	currquestion = currquestion + 1
	
	if(currquestion > Global.MultiplicationRound-1):
		$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = ("Finish")
		fintime = stepify(time_elapsed, 0.01)
		$Answer.visible = false
		$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = ("Time: " + str(fintime))
		yield(get_tree().create_timer(5.0), "timeout")
		get_tree().change_scene("res://Screen/MathPage/ChooseMenu.tscn")
	
	else:
		match hand[currquestion-1]:
				0:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/FinEquation.text = (str(seta[currquestion-1]) + "+" + str(setb[currquestion-1]) + "=" + str(answer[currquestion-1]))
				1:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/FinEquation.text = (str(seta[currquestion-1]) + "x" + str(setb[currquestion-1]) + "=" + str(answer[currquestion-1]))
				2:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/FinEquation.text = (str(seta[currquestion-1]) + "-" + str(setb[currquestion-1]) + "=" + str(answer[currquestion-1]))
		
		
		match hand[currquestion]:
				0:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "+" + str(setb[currquestion]) + "=")
				1:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "x" + str(setb[currquestion]) + "=")
				2:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Equation.text = (str(seta[currquestion]) + "-" + str(setb[currquestion]) + "=")
		
		if currquestion > Global.MultiplicationRound-2:
			$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = ("")
		else:
			match hand[currquestion+1]:
				0:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "+" + str(setb[currquestion+1]) + "=")
				1:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "x" + str(setb[currquestion+1]) + "=")
				2:
					$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/Upcoming.text = (str(seta[currquestion+1]) + "-" + str(setb[currquestion+1]) + "=")

func _on_LineEdit_text_changed(new_text):
	if($VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineEdit.text == (str(answer[currquestion]))):
		$Answer.text = "True"
		$VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineEdit.text = ""
		changequestion()
		$Score.text = str(currquestion)
	else:
		$Answer.text = "False"
	
