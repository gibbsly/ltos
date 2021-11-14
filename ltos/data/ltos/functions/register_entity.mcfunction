#writing uuid to scoreboard
data modify storage ltos:main uuid set from entity @s UUID
execute store result score @s ltos.uuid.0 run data get storage ltos:main uuid[0]
execute store result score @s ltos.uuid.1 run data get storage ltos:main uuid[1]
execute store result score @s ltos.uuid.2 run data get storage ltos:main uuid[2]
execute store result score @s ltos.uuid.3 run data get storage ltos:main uuid[3]

#tagging as registered
tag @s add ltos.registered

#debug stick check
execute if entity @s[type=minecraft:item,nbt={Item:{id:"minecraft:debug_stick"}}] if data entity @s Item.tag run function ltos:specify_output