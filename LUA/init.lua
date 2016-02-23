-- init.lua
-- Perhan Scudeller
-- 22/02/16

AP_SSID = "Perhan"
AP_PWD = ""
BROCKER = "192.168.2.1"
BR_PORT = 1880
BR_USER = "esp_robinet"
BR_PSW = "esp_robinet"
secure = 0 -- non sécurisé
autoreco = 0 -- se reconnect automatiquement 
TOPIC = "/PtEau"
QoS = 2 -- sauvegarde serveur jusqu'à transmision 
FILE = "poo_test.lua"
clientID = "rsp_mosquitto"
FREQ = 2 --(en min) envoie de données au serveur toutes les

print("open_init")

-- configuration pin 
--GPIO 0
pin=3
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.HIGH)

--GPIO 2
pin=4
gpio.mode(pin, gpio.INT)
pulse=0

-- se connecter a l'AP(a améliorer)!!!
print("Configuring WIFI...")
wifi.setmode( wifi.STATION )
wifi.sta.config(AP_SSID, AP_PWD)
print("Waiting for connection")
tmr.delay(15*1000000) --attente de connexion de 15sec !!
ip_addr_AP = wifi.sta.getconfig()
ip_addr = wifi.sta.getip()
if (ip_addr == nil) then
    print("Sorry. Not able to connect as : " ..wifi.sta.status())
    print("For more details ask admin \n or see : http://nodemcu.readthedocs.org/en/dev/en/modules/wifi/#wifistastatus ")
else 
    print("Connected to : " ..ip_addr_AP)
    print("Connected as : " ..ip_addr)
    print("MAC adress is : " ..wifi.sta.getmac())
end

-- ouvrir connexion mqtt
print ("Connecting to MQTT broker. Please wait...")
m = mqtt.Client(clientID, 120, BR_USER, BR_PWD)
m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)
m:connect(BROCKER, BR_PORT, secure, autoreco, function (client) print("connected") end)
--m:suscribe(TOPIC, QoS, function(client) print("subscribe success") end)

dofile(FILE)

print("exit_init")
