extends CharacterBody2D

var _velocidad: float = 200.0
var _velocidad_salto: float = -500.0
	
func _physics_process(delta):
	#gravedad
	velocity += get_gravity() * delta
	
	#Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _velocidad_salto
	
	#movimiento
	if Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
	else:
		velocity.x = 0
	move_and_slide()
