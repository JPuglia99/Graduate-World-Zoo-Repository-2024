xquery version "1.0" encoding "utf-8";
 
(:: OracleAnnotationVersion "1.0" ::)
 
declare namespace ns1="http://example.com/animalSchema";
(:: import schema at "../schema/ZooAnimals.xsd" ::)
 
declare variable $getAnimalNamesRequest as element() (:: schema-element(ns1:getAnimalNamesRequest) ::) external;
 
declare function local:func($getAnimalNamesRequest as element() (:: schema-element(ns1:getAnimalNamesRequest) ::)) as element() (:: schema-element(ns1:getAnimalStatsResponse) ::) {
<ns1:getAnimalStatsResponse>
{
for $animal in $getAnimalNamesRequest/ns1:animal
  return 
  <ns1:animal>
        <ns1:name>
                {data($animal/ns1:name)}
        </ns1:name>
        <ns1:species>
                {data($animal/ns1:species)}
        </ns1:species>
        <ns1:habitat>
                {data($animal/ns1:habitat)}
        </ns1:habitat>
  </ns1:animal>
  
}
</ns1:getAnimalStatsResponse>
};
 
local:func($getAnimalNamesRequest)
