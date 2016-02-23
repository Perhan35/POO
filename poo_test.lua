-- poo_test.lua
-- Perhan Scudeller
-- 22/02/16

print("poo_test.lua - debut")

-- récuperer donnees sur GPIO/gpio
function plusone(level)
    pulse=1
end

--execute fn quand front montant
gpio.trig(pin, "up", plusone(level)) 
-- envoyer donnes via reseau.mqtt
m:publish("/PtEau", pulse, 2, 0,0, function (client) print("sent") end)




-- traiter donnees recuperees/?

-- ?? ouvrir connection reseau /net.

-- ?? fermer connection reseau /net.

-- mettre en mode sleep /attendre nouvelle entree(external interrupts) 
--node.restart()

print("poo_test.lua - fin")