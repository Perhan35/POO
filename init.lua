-- init.lua
-- Perhan Scudeller
-- 22/02/16

print("open_init")

-- configuration pin 
--GPIO 0
pin=3
gpio.mode(pin, gpio.INT)
pulse=0

-- ouvrir connexion mqtt
m = mqtt.Client("rsp_mosquitto", 120, "esp_robinet", "esp_robinet")
m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)
m:connect("192.168.2.1", 1880, 0, 1, function (client) print("connected") end)
m:suscribe("/PtEau", 2, function(client) print("subscribe success") end)

dofile("poo_test.lua")

print("exit_init")