extends "res://disc1.gd"

func _ready():
    free_texture   = load("res://art_assets/disc3_free.png")
    linked_texture = load("res://art_assets/disc3_linked.png")
    allowed_discs_under = [1, 2]
    disc_offset = -4
    disc_id = 3
