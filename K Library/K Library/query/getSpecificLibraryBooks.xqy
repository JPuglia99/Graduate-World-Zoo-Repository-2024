xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace lib="http://www.KLibrary.com/librarySchema";
(:: import schema at "../schema/klibraryschema.xsd" ::)

declare variable $getDynamicRequest as element() (:: schema-element(lib:getDynamicBookRequest) ::) external;
declare variable $getDynamicResponse as element() (:: schema-element(lib:getDynamicBookResponse) ::) external;
declare variable $getCombinedLibrary as element() (:: schema-element(lib:getLibraryBooksDataResponse) ::) external;

declare function local:func($getDynamicRequest as element() (:: schema-element(lib:getDynamicBookRequest) ::)) as element() (:: schema-element(lib:getDynamicBookResponse) ::) {
    <lib:getDynamicBooksResponse>
    <lib:results>
    {
    let $findTitle := fn:lower-case(normalize-space($getDynamicRequest/lib:title))
    let $findAuthor := fn:lower-case(normalize-space($getDynamicRequest/lib:author))
    let $books := $getCombinedLibrary//lib:books
    
    return
    if ($findAuthor != "" and $findTitle != "") then (
      for $library in $getCombinedLibrary/lib:library
        for $book in $library/lib:books/lib:book
        let $bookTitle := fn:lower-case($book/lib:title)
        let $bookAuthor := fn:lower-case($book/lib:author)
        where fn:contains($bookTitle, $findTitle) and fn:contains($bookAuthor, $findAuthor)
        return 
          <lib:result>
            <lib:libraryName>{fn:data($library/lib:libraryName)}</lib:libraryName>
            <lib:title>{fn:data($book/lib:title)}</lib:title>
            <lib:author>{fn:data($book/lib:author)}</lib:author>
            <lib:message>Book found.</lib:message>
          </lib:result> 
            
    )
    else if ($findAuthor = "" and $findTitle != "") then (
        for $library in $getCombinedLibrary/lib:library
            for $book in $library/lib:books/lib:book
            let $bookTitle := fn:lower-case($book/lib:title)
            let $bookGenre := fn:lower-case($book/lib:genre)
            where fn:contains($bookTitle, $findTitle) or fn:contains($bookGenre,$findTitle)
            return
                <lib:result>
                    <lib:libraryName>{fn:data($library/lib:libraryName)}</lib:libraryName>
                    <lib:title>{fn:data($book/lib:title)}</lib:title>
                    <lib:author>{fn:data($book/lib:author)}</lib:author>
                    <lib:message>Book with title found.</lib:message>
                </lib:result>
    )
    else if ($findAuthor != "" and $findTitle = "") then (
        for $library in $getCombinedLibrary/lib:library
            for $book in $library/lib:books/lib:book
            let $bookAuthor := fn:lower-case($book/lib:author)
            where fn:contains($bookAuthor, $findAuthor)
            return
                <lib:result>
                    <lib:libraryName>{fn:data($library/lib:libraryName)}</lib:libraryName>
                    <lib:title>{fn:data($book/lib:title)}</lib:title>
                    <lib:author>{fn:data($book/lib:author)}</lib:author>
                    <lib:message>Book with author found.</lib:message>
                </lib:result>
    )
    else if ($findAuthor = "" and $findTitle = "") then (
        for $library in $getCombinedLibrary/lib:library
            for $book in $library/lib:books/lib:book
            return
                <lib:result>
                    <lib:libraryName>{fn:data($library/lib:libraryName)}</lib:libraryName>
                    <lib:title>{fn:data($book/lib:title)}</lib:title>
                    <lib:author>{fn:data($book/lib:author)}</lib:author>
                    <lib:message>Book with author found.</lib:message>
                </lib:result>
    )
    else
        <lib:result>
            <lib:libraryName></lib:libraryName>
            <lib:title></lib:title>
            <lib:author></lib:author>
            <lib:message>No books found with set criteria.</lib:message>
        </lib:result>
        
        } </lib:results>
        </lib:getDynamicBooksResponse>
};

local:func($getDynamicRequest)
