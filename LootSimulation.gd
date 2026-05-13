extends Node


var LT_Master: LootTable = preload("res://Loot/LT_Master.tres")


func on_fill_buckets() -> void:
    var _lib = Engine.get_meta("RTVModLib")
    var _caller = _lib._caller
    
    if LT_Master.items.size() != 0:
        for item in LT_Master.items:
            if item.name == "Empty Can":
                continue

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
    
    _caller.rarityRoll = randi_range(1, 100)
    if _caller.joker: _caller.rarityRoll = 100
    
    
    
    _lib.skip_super()
