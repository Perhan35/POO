-- init.lua
-- Perhan Scudeller
-- 24/02/16
-- v1.0

print("open_init")

--Assignation des parametres
AP_SSID = "Perhan"
AP_PWD = "" --ne pas oublier de modifier !! 
BROCKER = "192.168.1.6"
BR_PORT = 1883
BR_USER = ""
BR_PWD = ""
secure = 0 -- non sécurisé
autoreco = 0 -- ne se reconnect pas automatiquement 
TOPIC = "trial_topic"
QoS = 0 -- non sauvegarde serveur jusqu'à transmision 
clientID = ""
FREQ = 2 --(en min) envoie de données au serveur toutes les
--watch out freg, used for debug 

-- configuration pin 
--GPIO 0
pin=3
clock=1
rapport_cyclique=200
pwm.setup(pin, clock, rapport_cyclique)
pwm.start(pin)

--GPIO 2
pin=4
--gpio.mode(pin, gpio.INT, gpio.PULLUP)
gpio.mode(pin, gpio.INT)
pulse=0

-- se connecter a l'AP(a améliorer)!!!
print("Configuring WIFI...")
wifi.setmode(wifi.STATION)
wifi.sta.config(AP_SSID, AP_PWD)
wifi.sta.connect()
print("Waiting for connection.")
tmr.delay(10*1000000) --attente de connexion de 15sec !!
ip_addr_AP = wifi.sta.getconfig()
ip_addr = wifi.sta.getip()
if (ip_addr == nil) then
    print("Sorry. Not able to connect as : " ..wifi.sta.status())
    print("For more details ask admin \n or see : http://nodemcu.readthedocs.org/en/dev/en/modules/wifi/#wifistastatus")
else 
    print("Connected to : " ..ip_addr_AP)
    print("Connected as : " ..ip_addr)
    print("MAC adress is : " ..wifi.sta.getmac())
end

-- ouvrir connexion mqtt
print ("Connecting to MQTT broker. Please wait...")
m = mqtt.Client(clientID, 60, BR_USER, BR_PWD)
print("4")
tmr.delay(15*1000000)
m:connect("192.168.1.6", 1883, 0, 0, function (client) print("connected") end)
print("3")
tmr.delay(15*1000000)
m:on("connect", function(client) 
                        print ("connected") 
                        m:subscribe(TOPIC, QoS, function(client) print("subscribe success") end)
                        end)
print("2")
tmr.delay(5*1000000)
m:on("offline", function(client) print ("offline") end)
print("1")
tmr.delay(5*1000000) --attente de connexion de 15sec !!

-- récuperer donnees sur GPIO/gpio
function plusone(level)
    pulse=1
    print("+1") --for debug only
end

--execute fonction quand front montant
gpio.trig(pin, "up", plusone) 


-- envoyer donnes via reseau.mqtt toutes les 
tmr.alarm(0, FREQ*60000, tmr.ALARM_AUTO, function() 
        pulse = pulse/450
        m:publish(TOPIC, pulse, 0, QoS, 0, function (client) 
            print("sent") 
            end)
        print ("sent_pulse = " ..pulse)
        pulse = 0 
        wifi.sleeptype(wifi.MODEM_SLEEP)
        end)


-- mettre en mode sleep /attendre nouvelle entree(external interrupts) 


print("exit_init")
