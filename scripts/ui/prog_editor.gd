extends PanelContainer


var cur_program: ProgData = ProgData.new() : 
	set = _set_program

@onready var _var_list : ItemList = $VBoxContainer/GridContainer/PanelContainer/Variables/VBoxContainer/VariableList
@onready var _var_b_delete : Button = $VBoxContainer/GridContainer/PanelContainer/Variables/VBoxContainer/RemoveVarButton


## load the program data and create the scene to interact with
func _set_program(program: ProgData) -> void:
	pass


func upload_hack() -> void:
	pass


func create_variable() -> void:
	cur_program.variable_ids.append("Var_%s" % cur_program.variable_ids.size())
	pass


func display_variables() -> void:
	_var_list.clear()
	for v in cur_program.variable_ids:
		_var_list.add_item(v)

## activates the delete button
func _on_variable_list_item_selected(index: int) -> void:
	_var_b_delete.disabled = false


func _on_variable_list_empty_clicked(at_position: Vector2, mouse_button_index: int) -> void:
	_var_b_delete.disabled = true


func _on_variable_name_field_text_submitted(new_text: String) -> void:
	if new_text == null or new_text.is_empty():
		return
	# for now limit all variables to upper case only
	var name := new_text.to_upper()
	# verify this variable does not already exist
	if cur_program.variable_ids.has(name):
		# TODO: some sort of failure state / popup
		return
	cur_program.variable_ids.append(name)
	
	display_variables()


func _on_remove_var_button_pressed() -> void:
	# TODO: some sore of failure state / popup
	if not _var_list.is_anything_selected():
		return
	
	var i := _var_list.get_selected_items()[0]
	cur_program.variable_ids.remove_at(i)
	
	display_variables()
