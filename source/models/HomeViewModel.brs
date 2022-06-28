'************
'- Function Name:  ``HomeViewModel``
'- Return:  return as obejct
' **Description: This function will return the homeView Model object
'************
function HomeViewModel() as object
    if m._homeViewModelSingleton = invalid
        prototype = {}

        ' Private property
        prototype._shows = invalid
        prototype._categoryWiseShows = invalid
        prototype._menus = []
        prototype._selectedMenuIndex = 0

        '=========================================
        '# {Start}:Public Functions 
        '========================================
        prototype.init = sub()
            getShow()
        end sub

        prototype.getMenuItems = function() as object
            shows = m.getShows()
            showsbyTypes = filterArrWithKey(shows,"type")
            showsbyTypes.append({"All":shows})
            m._categoryWiseShows = showsbyTypes
            m._menus.append(showsbyTypes.keys())
            menuContentNode = createObject("roSGNode", "ContentNode")
            for index = 0 to m._menus.count() - 1
                menu = menuContentNode.createChild("MenuContentNode")
                menu.isSelected = index = m._selectedMenuIndex
                menu.title = m._menus[index]
            end for
            
            return menuContentNode
        end function
        '=========================================
        '# {End}:Public Functions 
        '========================================
        
        '=========================================
        '# {Start}:Setter || getter methods
        '========================================
        prototype.setShows = function(shows as object)as boolean
            m._shows = shows
            return true
        end function

        prototype.getShows = function() as object
            return m._shows
        end function

        prototype.getShowsForSelectedMenu = function() as object
            showkey =  m._menus[m._selectedMenuIndex]
            shows = m._categoryWiseShows[showkey]
            showContentNode = createObject("roSGNode", "ContentNode")
            for each showItem in shows
                showNode = showContentNode.createChild("ShowContentNode")
                showNode.title = showItem.name
                showNode.description = replaceTagAll(showItem.summary)
                showNode.posterURL = showItem.image.original
                showNode.id = showItem.id
            end for

            return showContentNode
        end function

        prototype.setSelectedMenu = function(index as integer)as boolean
            m._selectedMenuIndex = index
            return true
        end function

        prototype.getSelectedMenu = function() as integer
            return m._selectedMenuIndex
        end function
        

        '=========================================
        '# {End}:Setter || getter methods
        '========================================


        '=========================================
        '# {Start}:API Response Handler function
        '========================================
        prototype.onReceivedShows = sub(shows as object)
            m.setShows(shows)
        end sub
        '=========================================
        '# {End}:API Response Handler function
        '========================================



        m._homeViewModelSingleton = prototype
    end if

    return m._homeViewModelSingleton
end function

'=========================================
'# {Start}:Handle API Functions
'========================================
'************
'- Function Name:  ``getShow``
'- Return: retunr as object
' **Description: This function will trigger a Task node to get Shows from API
'************
sub getShow()

    createTaskPromise("ContentServiceTask", { runFunction: "fetchShows" }, true, "response").then(sub(response as object)
        if response.status = 200
            if m._homeviewmodelsingleton <> invalid
                m._homeviewmodelsingleton.onReceivedShows(response.body.json)
                m._homeViewControllerSingleton.onReceivedShows()
            end if
        end if

    end sub)
end sub

'=========================================
'# {End}:Handle API Functions
'========================================

function replaceTagAll(value as string)as string
    return value.replace("<p>","").replace("</p>","").replace("<b>","").replace("</b>","")
end function