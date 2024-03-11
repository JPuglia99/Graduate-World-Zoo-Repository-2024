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
    <ns1:description>HAHA</ns1:description>
    <ns1:flightPlanList>
    {
      for $plann in $getPlanBNE/ns1:flightPlanList/ns1:flightPlan
      return
      <ns1:flightPlan></ns1:flightPlan>
    }
    {
      for $plann in $getPlanMEL/ns1:flightPlanList/ns1:flightPlan
      return
      <ns1:flightPlan></ns1:flightPlan>
    }
    </ns1:flightPlanList>
    </ns1:getPlaneResponse>
};

local:func($getPlanRequest)

