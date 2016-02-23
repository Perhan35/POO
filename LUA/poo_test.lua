-- poo_test.lua
-- Perhan Scudeller
-- 22/02/16

print("poo_test.lua - debut")

-- récuperer donnees sur GPIO/gpio
function plusone(level)
    pulse=1
    --for debug only
    print("+1") 
end

--execute fn quand front montant
gpio.trig(pin, "up", plusone) 


-- envoyer donnes via reseau.mqtt toutes les 
tmr.alarm(0, FREQ*60000, 0, function() 
        pulse = pulse/450
        m:publish(TOPIC, pulse, 2, QoS, 0, function (client) 
            print("sent") 
            end)
        pulse = 0 
        wifi.sleeptype(wifi.MODEM_SLEEP)
        end)


-- mettre en mode sleep /attendre nouvelle entree(external interrupts) 


print("poo_test.lua - fin")
