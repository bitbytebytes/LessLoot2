extends Node

var _lib = null
var _container: Variant = null
var _simulation: Variant = null

func _ready():
    lessloot_log("Starting setup")
    _container = preload("res://mods/LessLoot2/LootContainer.gd").new()
    _simulation = preload("res://mods/LessLoot2/LootSimulation.gd").new()
    
    if Engine.has_meta("RTVModLib"):
        var lib = Engine.get_meta("RTVModLib")
        if lib._is_ready():
            _on_lib_ready()
        else:
            lib.frameworks_ready.connect(_on_lib_ready)
    

func _on_lib_ready():
    _lib = Engine.get_meta("RTVModLib")
    
    _lib.hook("lootcontainer-fillbuckets", _container.on_fill_buckets)
    _lib.hook("lootcontainer-generateloot", _container.on_generate_loot)
    
    _lib.hook("lootsimulation-fillbuckets", _simulation.on_fill_buckets)
    _lib.hook("lootsimulation-generateloot", _simulation.on_generate_loot)
    
    lessloot_log("hooks registered, setup complete")
    

func lessloot_log(message: String) -> void:
    print("[LessLoot2] " + message)
