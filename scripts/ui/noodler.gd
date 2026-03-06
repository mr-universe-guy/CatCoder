class_name Noodler
extends Control

@export var noodle_texture : Texture2D = preload("res://assets/kenney/ui/UIPack/check_square_color.png")

var origin: CanvasItem:
	set = _set_origin
var noodle: Line2D = Line2D.new()


func _enter_tree() -> void:
	if noodle_texture:
		noodle.texture = noodle_texture
		noodle.texture_mode = Line2D.LINE_TEXTURE_STRETCH
	set_notify_transform(true)
	var origin_pos := origin.get_global_transform_with_canvas().get_origin()
	noodle.add_point(origin_pos)
	noodle.add_point(Vector2.ZERO)
	add_child(noodle)


func _draw_noodle() -> void:
	var origin_pos := origin.get_global_transform_with_canvas().get_origin()
	var noodle_pos := get_global_transform_with_canvas().get_origin()
	noodle.set_point_position(0, origin_pos-noodle_pos)


func _set_origin(o: CanvasItem) -> void:
	if origin and origin.item_rect_changed.is_connected(_draw_noodle):
		origin.item_rect_changed.disconnect(_draw_noodle)
	origin = o
	origin.item_rect_changed.connect(_draw_noodle)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		_draw_noodle()
