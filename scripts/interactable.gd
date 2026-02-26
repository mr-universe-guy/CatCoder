class_name Interactable
extends Node3D

## emitted when a player interacts with this object
signal interacted(player: Player)

## text to display above the object when the player is targetting it
@export var display_text: String = ""

## called by the player when the press the interact button with this object targetted
func interact(player: Player) -> void:
	interacted.emit(player)
