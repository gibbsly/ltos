#writing data from item into storage
data modify storage ltos:main data set from entity @s Item.tag

#determining what tags to run, 1; player, 2; entity, 3; owned, 4; uncheckable
scoreboard players set type= ltos.main 2
execute if data storage ltos:main data{killed_by:"player"} run scoreboard players set type= ltos.main 1
execute if data storage ltos:main data{killed_by:"command"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"creeper"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"dragon_fireball"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"egg"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"end_crystal"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"ender_pearl"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"experience_bottle"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"fireball"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"llama_spit"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"potion"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"shulker_bullet"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"small_fireball"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"snowball"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"tnt"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"tnt_minecart"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data{killed_by:"wither_skull"} run scoreboard players set type= ltos.main 4
execute if data storage ltos:main data.killer_owner_uuid run scoreboard players set type= ltos.main 3

#getting uuid
execute unless score type= ltos.main matches 3 run function ltos:specify_output/entity/uuid
execute if score type= ltos.main matches 3 run function ltos:specify_output/entity/owner

#running tag at entity pre-killer
execute align xyz positioned ~0.5 ~0.5 ~0.5 run function #ltos:as_entity

#running tag as killer
execute if score type= ltos.main matches 1 as @a[distance=..10] if score @s ltos.uuid.0 = uuid.0 ltos.main if score @s ltos.uuid.1 = uuid.1 ltos.main if score @s ltos.uuid.2 = uuid.2 ltos.main if score @s ltos.uuid.3 = uuid.3 ltos.main at @s run function #ltos:as_killer
execute if score type= ltos.main matches 2 as @e[distance=..10,type=!#ltos:skip] if score @s ltos.uuid.0 = uuid.0 ltos.main if score @s ltos.uuid.1 = uuid.1 ltos.main if score @s ltos.uuid.2 = uuid.2 ltos.main if score @s ltos.uuid.3 = uuid.3 ltos.main at @s run function #ltos:as_killer
execute if score type= ltos.main matches 3 as @e[type=!#ltos:skip] if score @s ltos.uuid.0 = uuid.0 ltos.main if score @s ltos.uuid.1 = uuid.1 ltos.main if score @s ltos.uuid.2 = uuid.2 ltos.main if score @s ltos.uuid.3 = uuid.3 ltos.main at @s run function #ltos:as_killer

#running function as entity
execute align xyz positioned ~0.5 ~0.5 ~0.5 run function #ltos:as_killed_entity

#terminating item
kill @s