-- init.lua
-- Perhan Scudeller
-- 24/02/16
-- v0.1

--INITIALISATION

-- Variables 
pulse = 0 -- compte les pulsations 
co = 0 -- non connecté au serveur
PORT_SERVER = "1111"
IP_SERVER = "192.168.2.1"
FREQ = 1 --(en sec) envoie de données au serveur toutes les

-- configuration pin
--GPIO 2
pin=4
--gpio.mode(pin, gpio.INT, gpio.PULLUP)
gpio.mode(pin, gpio.INT)
pulse=0

-- set CPU freq (low)
node.setcpufreq(node.CPU80MHZ)

--Configures the WiFi modem sleep type.
wifi.sleeptype(wifi.MODEM_SLEEP)

-- fixer son adresse IP 
wifi.sta.setip({ip="192.168.2.2",netmask="255.255.252.0",gateway="192.168.2.1"})
print("IP_ESP : " ..wifi.sta.getip())

-- Donner un petit nom au module 
name = node.chipid()

--END OF INIT


-- récuperer donnees sur GPIO/gpio
function plusone(level)
    pulse=1
    print("+1") --for debug only
end

--execute fonction quand front montant
gpio.trig(pin, "up", plusone)


-- connexion à l'AP ??
--wifi.sta.config(ssid, password, 0, bssid)
--wifi.sta.connect()

-- creer client TCP
sk = net.createConnection(net.TCP, 0)

-- Register callback functions for specific events 
sk:on("connection", function (sck,c) 
                            co = 1 
                            print("connecté au serveur")
                    end)

-- connect to a remote server 
sk:connect(PORT_SERVER,IP_SERVER)

-- Send data to server !!!(A AMELIORER !!!!) + cf #730

------------------------
tmr.alarm(0, FREQ*1000, tmr.ALARM_AUTO, function()
    if (pulse ~= 0 ) & ( co == 1) then 
        pulse = pulse/450
        sk:send(..name " : " ..pulse, function(sent)
                            print("sent : " ..sent) 
                            end)
        print ("sent_pulse = " ..pulse)
        pulse = 0 
     end
  end)


