xquery version "1.0" encoding "utf-8";
 
(:: OracleAnnotationVersion "1.0" ::)
 
declare namespace ns1="http://example.com/animalSchema";
(:: import schema at "../schema/ZooAnimals.xsd" ::)
 
declare variable $getAnimalStatsRequest as element() (:: schema-element(ns1:getAnimalStatsRequest) ::) external;

declare variable $getSydAnimals as element() (:: schema-element(ns1:getAnimalStatsResponse) ::) external;
declare variable $getPerthAnimals as element() (:: schema-element(ns1:getAnimalStatsResponse) ::) external;

 
declare function local:func($getAnimalStatsRequest as element() (:: schema-element(ns1:getAnimalStatsRequest) ::)) as element() (:: schema-element(ns1:getAnimalStatsResponse) ::) {

<ns1:getAnimalStatsResponse>

 

{
for $animal in $getSydAnimals/ns1:animal
  return
  <ns1:animal>
    <ns1:name>Sydney {data($animal/ns1:name)}</ns1:name>
    <ns1:species> {data($animal/ns1:species)}</ns1:species>
    <ns1:habitat>Sydney {data($animal/ns1:habitat)}</ns1:habitat>
  </ns1:animal>
}

{
  for $animal in $getPerthAnimals/ns1:animal
  return
  <ns1:animal>
    <ns1:name>Perth {data($animal/ns1:name)}</ns1:name>
    <ns1:species> {data($animal/ns1:species)}</ns1:species>
    <ns1:habitat>Perth {data($animal/ns1:habitat)}</ns1:habitat>
  </ns1:animal>
}
</ns1:getAnimalStatsResponse>
};
 
local:func($getAnimalStatsRequest)
