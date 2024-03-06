xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace anim="http://example.com/animalSchema";
(:: import schema at "../schema/ZooAnimals.xsd" ::)

declare variable $getAnimalNamesRequest as element() (:: schema-element(anim:getAnimalNamesRequest) ::) external;

declare function local:func($getAnimalNamesRequest as element() (:: schema-element(anim:getAnimalNamesRequest) ::)) as element() (:: schema-element(anim:getAnimalNamesResponse) ::) {
    <anim:getAnimalNamesResponse>
      <anim:name>
        {fn:string-join(fn:data($getAnimalNamesRequest/anim:animal/anim:name), ", ")}
      </anim:name>
    </anim:getAnimalNamesResponse>
};

local:func($getAnimalNamesRequest)
