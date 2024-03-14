xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://example.com/aircraftSchema";
(:: import schema at "../schema/Aircraft.xsd" ::)

declare namespace ns2="http://example.com/aircraftBaseSchema";
(:: import schema at "../schema/AircraftBase.xsd" ::)

declare variable $getPlanRequest as element() (:: schema-element(ns1:getPlanRequest) ::) external;
declare variable $getPlanBNE as element() (:: schema-element(ns1:getPlanResponse) ::) external;
declare variable $getPlanMEL as element() (:: schema-element(ns1:getPlanResponse) ::) external;

declare function local:func($getPlanRequest as element() (:: schema-element(ns1:getPlanRequest) ::) (:: schema-element(ns1:getPlanResponse) ::)) {
    
    
    <ns1:getPlaneResponse>
    <ns1:description> Flight plans for { 
        for $plane in $getPlanRequest/ns1:regoList/ns1:rego
        return
        (data($plane), ' ')
    }are:
    </ns1:description>
    <ns1:flightPlanList>
    {
      for $planeRego in $getPlanRequest/ns1:regoList/ns1:rego
      return
      
        for $plan in (($getPlanBNE/ns1:flightPlanList/ns1:flightPlan),($getPlanMEL/ns1:flightPlanList/ns1:flightPlan))
        return
        
          if ($plan/ns2:regoNo = $planeRego) 
          then 
          <ns1:flightPlan>
            <ns2:regoNo>
              {data($plan/ns2:regoNo)}
            </ns2:regoNo>
            <ns2:toWeight>
              {data($plan/ns2:toWeight)}
            </ns2:toWeight>
            <ns2:rule>
              {data($plan/ns2:rule)}
            </ns2:rule>
            <ns2:departure>
              {data($plan/ns2:departure)}
            </ns2:departure>
            <ns2:desto>
              {data($plan/ns2:desto)}
            </ns2:desto>
          </ns1:flightPlan>
          else()
      
    }

    </ns1:flightPlanList>
    </ns1:getPlaneResponse>
};

local:func($getPlanRequest)

