xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace lib="http://www.KLibrary.com/librarySchema";
(:: import schema at "../schema/klibraryschema.xsd" ::)

declare variable $getLoanDetailsRequest as element() (:: schema-element(lib:getLoanDetailsRequest) ::) external;
declare variable $getLoanData as element() (:: schema-element(lib:getLoanDataResponse) ::) external;
declare variable $getMemberData as element() (:: schema-element(lib:getMemberDataResponse) ::) external;

declare function local:func($getLoanDetailsRequest as element() (:: schema-element(lib:getLoanDetailsRequest) ::)) as element() (:: schema-element(lib:getLoanDetailsResponse) ::) {
    <lib:getLoanDetailsResponse> {
      let $loanID := normalize-space($getLoanDetailsRequest/lib:loanID)
        return $loanID
    }</lib:getLoanDetailsResponse>
};

local:func($getLoanDetailsRequest)
