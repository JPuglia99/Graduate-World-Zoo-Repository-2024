xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://example.com/aircraftSchema";

(:: import schema at "../schema/Aircraft.xsd" ::)

declare namespace ns2="http://example.com/aircraftBaseSchema";

(:: import schema at "../schema/AircraftBase.xsd" ::)

declare variable $getPlaneRequest as element() (:: schema-element(ns1:getPlaneRequest) ::) external;
declare variable $getPlaneBNE as element() (:: schema-element(ns1:getPlaneResponse) ::) external;
declare variable $getPlaneMEL as element() (:: schema-element(ns1:getPlaneResponse) ::) external;
 

declare function local:func($getPlaneRequest as element() (:: schema-element(ns1:getPlaneRequest) ::) (:: schema-element(ns1:getPlaneResponse) ::)) {
    <ns1:getPlaneResponse>
    <ns1:description> There are currently {
           count($getPlaneBNE/ns1:aircraftList/ns1:aircraft)+count($getPlaneMEL/ns1:aircraftList/ns1:aircraft)
    } aircraft airborne in Australia
    </ns1:description>
    
    <ns1:aircraftList>
    {
      for $plane in $getPlaneBNE/ns1:aircraftList/ns1:aircraft
      return
      <ns1:aircraft>
        <ns2:callsign>
          {
          if (string-length(normalize-space($plane/ns2:callsign))>0) then
  
          data($plane/ns2:callsign)
          
          else
          (:if no callsign, callsign == rego :)
          
          data($plane//ns2:regoNo)
          
        }
        
        </ns2:callsign>
        <ns2:aircraftModel>
          <ns2:aircraftBuilder> {data($plane//ns2:aircraftBuilder)} </ns2:aircraftBuilder>
          <ns2:aircraftModel> {data($plane/ns2:aircraftModel/ns2:aircraftModel)} </ns2:aircraftModel>
        </ns2:aircraftModel>
        
        <ns2:aircraftRego>
          <ns2:ownerName> {data($plane//ns2:ownerName)} </ns2:ownerName>
          <ns2:regoNo> {data($plane//ns2:regoNo)}</ns2:regoNo>
          <ns2:ownerType> {data($plane//ns2:ownerType)} </ns2:ownerType>
          <ns2:code> {data($plane//ns2:code)} </ns2:code>
        </ns2:aircraftRego>
        
      </ns1:aircraft>
    }
     {
      for $plane in $getPlaneMEL/ns1:aircraftList/ns1:aircraft
      return
      <ns1:aircraft>
      {
        if (string-length(normalize-space($plane/ns2:callsign))>0) then
          <ns2:callsign>
          {data($plane/ns2:callsign)}
          </ns2:callsign>
        
        else
          (:if no callsign, callsign == rego :)
          <ns2:callsign>
            {data($plane//ns2:regoNo)}
          </ns2:callsign>
          
      }
        <ns2:aircraftModel>
          <ns2:aircraftBuilder> {data($plane//ns2:aircraftBuilder)} </ns2:aircraftBuilder>
          <ns2:aircraftModel> {data($plane/ns2:aircraftModel/ns2:aircraftModel)} </ns2:aircraftModel>
        </ns2:aircraftModel>
        
        <ns2:aircraftRego>
          <ns2:ownerName> {data($plane//ns2:ownerName)} </ns2:ownerName>
          <ns2:regoNo> {data($plane//ns2:regoNo)}</ns2:regoNo>
          <ns2:ownerType> {data($plane//ns2:ownerType)} </ns2:ownerType>
          <ns2:code> {data($plane//ns2:code)} </ns2:code>
        </ns2:aircraftRego>
        
      </ns1:aircraft>
    }
    </ns1:aircraftList>
    </ns1:getPlaneResponse>
};

local:func($getPlaneRequest)
