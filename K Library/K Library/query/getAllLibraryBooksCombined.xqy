xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace lib="http://www.KLibrary.com/librarySchema";
(:: import schema at "../schema/klibraryschema.xsd" ::)

declare variable $getLibraryBooksRequest as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) external;
declare variable $getSydneyLibrary as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) external;
declare variable $getPerthLibrary as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) external;
declare variable $getBrisbaneLibrary as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) external;

declare function local:func($getLibraryBooksRequest as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::)) as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) {
    <lib:getLibraryBooksDataResponse>{
        let $combined := ($getSydneyLibrary, $getPerthLibrary, $getBrisbaneLibrary)
        for $library in $combined/lib:library
        return
            $library
    }</lib:getLibraryBooksDataResponse>
};

local:func($getLibraryBooksRequest) 
