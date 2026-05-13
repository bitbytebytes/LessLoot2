extends Node


var LT_Master: LootTable = preload("res://Loot/LT_Master.tres")

var lootable_keys: Array = ["Cellar Key", "Gymnasium Key", "Tunnel Key"]
var loot_keys: Array = []


func on_fill_buckets() -> void:
    var _lib = Engine.get_meta("RTVModLib")
    var _caller = _lib._caller
    
    if LT_Master.items.size() != 0:
        for item in LT_Master.items:
            if item.name == "Empty Can":
                continue
                
            if item.name in lootable_keys:
                loot_keys.append(item)

            if item.rarity != item.Rarity.Null:

                if (_caller.civilian && item.civilian) || (_caller.industrial && item.industrial) || (_caller.military && item.military):

                    if _caller.limit == "" && _caller.exclude != item.type:
                        if item.rarity == item.Rarity.Common: _caller.commonBucket.append(item)
                        elif item.rarity == item.Rarity.Rare: _caller.rareBucket.append(item)
                        elif item.rarity == item.Rarity.Legendary: _caller.legendaryBucket.append(item)

                    elif _caller.limit == item.type:
                        if item.rarity == item.Rarity.Common: _caller.commonBucket.append(item)
                        elif item.rarity == item.Rarity.Rare: _caller.rareBucket.append(item)
                        elif item.rarity == item.Rarity.Legendary: _caller.legendaryBucket.append(item)
    
    _lib.skip_super()


func on_generate_loot() -> void:
    var _lib = Engine.get_meta("RTVModLib")
    var _caller = _lib._caller
    
    _caller.rarityRoll = randi_range(1, 199)
    if _caller.joker: _caller.rarityRoll = 200

    if _caller.rarityRoll == 1:
        _caller.CreateLoot(loot_keys.pick_random())
        
        if _caller.legendaryBucket.size() != 0:
            _caller.CreateLoot(_caller.legendaryBucket.pick_random())

    elif _caller.rarityRoll <= 5:
        if _caller.rareBucket.size() != 0:
            for pick in randi_range(1, 2):
                _caller.CreateLoot(_caller.rareBucket.pick_random())

    elif _caller.rarityRoll <= 25:
        if _caller.commonBucket.size() != 0:
            for pick in randi_range(1, 4):
                _caller.CreateLoot(_caller.commonBucket.pick_random())

    elif _caller.rarityRoll == 200:
        _caller.CreateLoot(loot_keys.pick_random())
            
        if _caller.legendaryBucket.size() != 0:
            _caller.CreateLoot(_caller.legendaryBucket.pick_random()) 
                
        if _caller.rareBucket.size() != 0:
            for pick in randi_range(2, 4):
                _caller.CreateLoot(_caller.rareBucket.pick_random())

        if _caller.commonBucket.size() != 0:
            for pick in randi_range(2, 4):
                _caller.CreateLoot(_caller.commonBucket.pick_random())
    
    _lib.skip_super()
    
