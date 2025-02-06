class_name Bullet
extends Area2D

@export var SPEED: float = 1000.0
@export	var RANGE: float = 1200.0
var TRAVELLED_DISTANCE: float = 0.0

func _physics_process(delta: float) -> void:
    var direction = Vector2.RIGHT.rotated(rotation)
    position += direction * SPEED * delta
    
    TRAVELLED_DISTANCE += SPEED * delta
    if TRAVELLED_DISTANCE >= RANGE:
        queue_free()
    
func _on_body_entered(body: Node2D) -> void:
    if body.has_method("take_damage"):
        body.take_damage()
        queue_free()
