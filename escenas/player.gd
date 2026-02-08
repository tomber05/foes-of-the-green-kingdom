extends CharacterBody2D

signal personaje_muerto

@export var animacion: Node
var _velocidad: float = 200.0
var _velocidad_salto: float = -560.0
var _muerto: bool

func ready():
	add_to_group("personajes")

func _physics_process(delta):
	#muerte
	if _muerto:
		return
	
	#animaciones
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x !=0:
		animacion.play("Andar")
	else:
		animacion.play("idle")
	
	#gravedad
	velocity += get_gravity() * delta
	
	#Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _velocidad_salto
	
	#movimiento
	if Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		animacion.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
		animacion.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	animacion.modulate = Color(1.0, 0.0, 0.0, 1.0)
	animacion.stop()
	_muerto = true
	await get_tree().create_timer(0.5).timeout
	personaje_muerto.emit()

	ControladorGlobal.sumar_muerte()
