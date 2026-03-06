extends Control

## the distance in pixels for one half of a joy axis
@export var max_distance := 50
## The input action to call when the x axis is positive
@export var action_x_pos : String
## The input action to call when the x axis is negative
@export var action_x_neg : String
## The input action to call when the y axis is positive
@export var action_y_pos : String
## The input action to call when the y axis is negative
@export var action_y_neg : String

var is_pressed := false
var start_pos : Vector2
var joy_axis := Vector2()

@onready var normal : Sprite2D = $normal
@onready var pressed : Sprite2D = $pressed

func _process(_delta: float) -> void:
	if is_pressed:
		if joy_axis.x > 0 :
			Input.action_press(action_x_pos, minf(joy_axis.x, 1.0))
		else :
			Input.action_press(action_x_neg, minf(-joy_axis.x, 1.0))
		
		if joy_axis.y > 0 :
			Input.action_press(action_y_pos, minf(joy_axis.y, 1.0))
		else :
			Input.action_press(action_y_neg, minf(-joy_axis.y, 1.0))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var touch := event as InputEventScreenTouch
		is_pressed = touch.is_pressed()
		
		if touch.is_pressed():
			start_pos = touch.position
			pressed.global_position = start_pos
			pressed.visible = true
			#print("drag start")
			
		elif touch.is_released():
			start_pos = Vector2.ZERO
			pressed.visible = false
			Input.action_release(action_x_pos)
			Input.action_release(action_x_neg)
			Input.action_release(action_y_pos)
			Input.action_release(action_y_neg)
			#print("drag stopped")
		
	if event is InputEventScreenDrag:
		var drag := event as InputEventScreenDrag
		var drag_delta := start_pos - drag.position
		joy_axis.x = -drag_delta.x / max_distance
		joy_axis.y = drag_delta.y / max_distance
		
		pressed.global_position = drag.position
		#print("joy axis: %s" % joy_axis)
