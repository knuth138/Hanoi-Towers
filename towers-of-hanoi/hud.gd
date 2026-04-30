extends CanvasLayer

var game_won = false

func _ready():
    hide()

func _on_tower_3_game_won():
    # don't play effect twice
    if not game_won:
        # show victory screen and play sfx
        show()
        $Cheer.play()
        game_won = true
