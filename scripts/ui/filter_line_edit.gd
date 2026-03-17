extends LineEdit

## regex pattern of allowable characters
@export var allowed_characters := "^[A-Za-z0-9]*"

@onready var regex := RegEx.create_from_string(allowed_characters)

func _ready() -> void:
	text_changed.connect(_filter_text)


func _filter_text(value: String) -> void:
	if not is_node_ready():
		return
		
	var word := ""
	var old_caret_pos := caret_column
	for c in regex.search_all(value):
		word += c.get_string()
	
	self.text = word
	caret_column = old_caret_pos
