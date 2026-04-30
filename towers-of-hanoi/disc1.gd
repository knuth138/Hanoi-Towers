extends Area2D

# number of discs allowed under the disc
# e.g. biggest disc must be on bottom, so this should be 0 for it
@export var allowed_discs_under = []
# vertical distance between discs on pole
@export var disc_height = 40
# horizontal distance to offset disc sprite, so it fits the pole sprite
@export var disc_offset = -3
# tower disc is on; must be set in editor for instance
@export var linked_tower: Area2D

# free texture for when disc is held on mouse
# linked texture is used when disc is on a pole
var free_texture
var linked_texture
var dragging = false
var original_pos
var has_tower_under = false
var tower_under
# id number of disc; same as in scene title
var disc_id = 1

func _ready():
	free_texture   = load("res://art_assets/disc1_free.png")
	linked_texture = load("res://art_assets/disc1_linked.png")

func _on_input_event(_viewport, event, _shape_idx):
	# when the mouse button is pressed or released
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# when mouse is clicked, pick up the disc for as long as it's held
		if not dragging and event.pressed and linked_tower.holding_discs.back() == disc_id:
			# switch texture to free texture
			$Sprite2D.texture = free_texture
			# save original position
			original_pos = position
			dragging = true
		# when mouse button is released
		if dragging and not event.pressed:
			# reset texture
			$Sprite2D.texture = linked_texture
			dragging = false
			# if disc is colliding with a tower, snap to the tower
			if has_tower_under and \
			tower_under.holding_discs.size() <= allowed_discs_under.size() and \
			not tower_under.contains_other_discs(allowed_discs_under):
				tower_under.add_disc(self)
				position.x = tower_under.position.x + disc_offset
				position.y = -disc_height * (tower_under.holding_discs.size()) + tower_under.position.y
				# remove disc from previous tower and link to new tower
				linked_tower.remove_disc(self)
				linked_tower = tower_under
			# otherwise, snap back to original position
			else:
				position = original_pos

# while mouse button is held, keep disc at mouse position
func _input(event):
	if event is InputEventMouseMotion and dragging:
		position = get_viewport().get_mouse_position()
