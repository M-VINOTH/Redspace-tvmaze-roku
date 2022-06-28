''
' Returns an object containing API utility functions.
'
''
function baseService() as object
    this = {
        ''
        ' Performs a GET request to the API.
        '
        ' @param {string} url - Request URL.
        ' @param {boolean} [isRetry] - Represents that the request is being retried.
        '
        ' @returns {dynamic} - response object or invalid on failure
        '
        get: function(url, eventCallback = invalid, isRetry = false, async = false) as dynamic

            return m._request(url, {}, {}, eventCallback, isRetry, async)
        end function

        ''
        ' Performs a POST request to the API.
        '
        ' @param {string} url - Request URL.
        ' @param {object} [data] - Request data.
        ' @param {boolean} [isRetry] - Represents that the request is being retried.
        '
        ' @returns {dynamic} - response object or invalid on failure
        '
        post: function(url, data = {}, options = {}, eventCallback = invalid, isRetry = false)
            options.httpMethod = "POST"
            return m._request(url, data, options, eventCallback, isRetry)
        end function


        ' ---------------------------------------------------------------------
        ' Private
        ' ---------------------------------------------------------------------

        ''
        ' Performs a request to the API.
        '
        ' @param {string} url - Request URL.
        ' @param {object} [data] - Request data.
        ' @param {object} [options] - Request options.
        ' @param {boolean} [isRetry] - Represents that the request is being retried.
        ' @param {string} [httpMethod] - http method.
        '
        ' @returns {dynamic} - response object or invalid on failure
        '
        _request: function(url, data = {}, options = {}, eventCallback = invalid, isRetry = false, async = false as boolean) as dynamic
            response = invalid
            if options.httpMethod = invalid
                options.httpMethod = "GET"
            end if

            headers = {
                "Content-Type": "application/json"
            }

            headers.append(options.headers)


            http = createObject("roUrlTransfer")
            http.setMessagePort(createObject("roMessagePort"))

            ' Pipes in URLs cause Roku's version of curl to return an error, so we need to manually escape them.
            ' Note that there are a few API URLs that use pipes.
            url = url.replace("|", http.escape("|"))
            http.setUrl(url)

            http.setHeaders(options.headers)
            http.enableEncodings(true) ' Accept gzipped payloads
            http.setCertificatesFile("common:/certs/ca-bundle.crt") ' HTTPS!
            http.retainBodyOnError(true) ' Return the body of the response even if the HTTP status code indicates that an error

            if options.httpMethod = "GET"
                wasRequestSent = http.asyncGetToString()
            else if options.httpMethod = "POST"
                if options.headers["Content-Type"] = "application/json"
                    body = formatJson(options.data)
                end if

                http.setRequest(options.method)
                wasRequestSent = http.asyncPostFromString(body)
            end if

            if wasRequestSent
                event = wait(0, http.getPort())
                if type(event) = "roUrlEvent"
                    response = {
                        ok: 200 <= event.getResponseCode() and event.getResponseCode() < 300,
                        status: event.getResponseCode(),
                        statusText: event.getFailureReason(),
                        headers: event.getResponseHeaders(),
                        body: {
                            text: event.getString(),
                            json: invalid
                        }
                    }

                    ' Response error.
                    if response.status < 0 then
                        http.asyncCancel()
                        return invalid
                    end if

                    'In some cases Content-Type may be "application/json; charset=utf-8" (or other?)
                    'so we try to define exactly "application/json"
                    isContentTypeJson = false
                    if response.headers["Content-Type"] <> invalid then isContentTypeJson = Instr(1, response.headers["Content-Type"], "application/json") <> 0
                    if isContentTypeJson and event.getString() <> ""
                        responseJson = parseJson(event.getString())
                        response.body.json = responseJson
                    end if

                    return response
                else if event = invalid
                    ' Request timed out.
                    http.asyncCancel()

                    return invalid
                end if
            end if
        end function
    }

    return this
end function

