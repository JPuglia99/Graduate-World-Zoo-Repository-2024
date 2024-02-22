xquery version "1.0" encoding "utf-8";
 
(:: OracleAnnotationVersion "1.0" ::)
 
declare namespace ns1="http://example.com/animalSchema";
(:: import schema at "../schema/ZooAnimals.xsd" ::)
 
declare variable $getAnimalNamesRequest as element() (:: schema-element(ns1:getAnimalNamesRequest) ::) external;
 
declare function local:func($getAnimalNamesRequest as element() (:: schema-element(ns1:getAnimalNamesRequest) ::)) as element() (:: schema-element(ns1:getAnimalNamesResponse) ::) {
<ns1:getAnimalNamesResponse xmlns:ns1="http://example.com/animalSchema">
<ns1:name>{string-join($getAnimalNamesRequest/ns1:animal/ns1:name, ', ')}</ns1:name>
</ns1:getAnimalNamesResponse>
};
 
local:func($getAnimalNamesRequest)
