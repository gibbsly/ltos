#main scoreboard
scoreboard objectives add ltos.main dummy
scoreboard players set $loaded ltos.main 1

#uuid scoreboards
scoreboard objectives add ltos.uuid.0 dummy
scoreboard objectives add ltos.uuid.1 dummy
scoreboard objectives add ltos.uuid.2 dummy
scoreboard objectives add ltos.uuid.3 dummy

#resetting storage
data modify storage ltos:main data set value {}