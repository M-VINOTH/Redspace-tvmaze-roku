sub init()
    m.baseURI = "https://api.tvmaze.com/"
end sub

'************
'- Function Name:  ``onRunFunctionUpdated``
'- Params:  event as object
' **Description: Here will get a function to run specific task
'************
sub onRunFunctionUpdated(event as object)
    m.top.functionName = event.getData()
end sub

'************
'- Function Name:  ``fetchShows``
'************
sub fetchShows()
    url = m.baseURI+"shows"
    response = baseService().get(url)
    m.top["response"] = response
end sub

'************
'- Function Name:  ``getEpisodes``
'************
sub getEpisodes()
    showID = m.top.data.showID
    url = m.baseURI+"shows/"+showID+"/episodes"
    response = baseService().get(url)
    m.top["response"] = response
end sub