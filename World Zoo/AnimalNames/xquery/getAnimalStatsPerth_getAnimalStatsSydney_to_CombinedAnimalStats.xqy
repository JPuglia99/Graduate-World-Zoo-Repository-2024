xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace anim="http://example.com/animalSchema";
(:: import schema at "../schema/ZooAnimals.xsd" ::)

declare variable $getAnimalStatsRequest as element() (:: schema-element(anim:getAnimalStatsRequest) ::) external;
declare variable $getASPerth as element() (:: schema-element(anim:getAnimalStatsResponse) ::) external;
declare variable $getASSydney as element() (:: schema-element(anim:getAnimalStatsResponse) ::) external;

declare function local:func($getAnimalStatsRequest as element() (:: schema-element(anim:getAnimalStatsRequest) ::)) as element() (:: schema-element(anim:getAnimalStatsResponse) ::) {
    <anim:getAnimalStatsResponse>
      <anim:name>
        {$getASPerth//anim:animal}
        {$getASSydney//anim:animal}
      </anim:name>
    </anim:getAnimalStatsResponse>
};

local:func($getAnimalStatsRequest)
