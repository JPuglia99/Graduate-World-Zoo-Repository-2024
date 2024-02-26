xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace fi="http://example.com/fighterSchema";
(:: import schema at "../schema/Fighters.xsd" ::)
declare namespace pay="http://example.com/payloadSchema";
(:: import schema at "../schema/Payload.xsd" ::)
declare namespace wep="http://example.com/weaponSchema";
(:: import schema at "../schema/Weapons.xsd" ::)

declare variable $fi:getFighterRequest as element() (:: schema-element(fi:getFighterRequest) ::) external;
declare variable $wep:getWeaponRequest as element() (:: schema-element(wep:getWeaponRequest) ::) external;

declare function local:getFNWRequest_to_getPayloadResponse($fi:getFighterRequest as element() (:: schema-element(fi:getFighterRequest) ::), 
                                                           $wep:getWeaponRequest as element() (:: schema-element(wep:getWeaponRequest) ::)) 
                                                           as element() (:: schema-element(pay:getPayloadResponse) ::) {
    <pay:getPayloadResponse>
      {
      for $fighter in $fi:getFighterRequest/fi:aircraft
        return
        <pay:aircraft>
        <pay:serial>{data($fighter/fi:serial)}</pay:serial>
        <pay:type>{data($fighter/fi:model)}</pay:type>
        <pay:role>
        {
        if(data($fighter/fi:role) = "F") then "Air Superiority Fighter"
          else if (data($fighter/fi:role) = "FB") then "Multirole Fighter"
          else if (data($fighter/fi:role) = "EW") then "Electronic Warfare"
          else ()
        }
        </pay:role>
        <pay:weaponList>
        {
            for $weapon in $wep:getWeaponRequest/wep:weapon
              for $i in tokenize($weapon/wep:role,',')
                return if($i = $fighter/fi:role) then
                  <pay:weapon>
                  {data($weapon/wep:model)}
                  </pay:weapon>
                  else() 
                  
        }
        </pay:weaponList>
        </pay:aircraft>
      }
      
    </pay:getPayloadResponse>

};

local:getFNWRequest_to_getPayloadResponse($fi:getFighterRequest, $wep:getWeaponRequest)
