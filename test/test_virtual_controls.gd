extends Control

@onready var joy_axis_x : ProgressBar = $VBoxContainer/x_axis
@onready var joy_axis_y : ProgressBar = $VBoxContainer/y_axis

func _process(_delta: float) -> void:
	joy_axis_x.value = Input.get_axis("move_left", "move_right")
	joy_axis_y.value = Input.get_axis("move_back", "move_forward")
