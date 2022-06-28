'************
'- Function Name:  ``HomeViewController``
'- Return: return type as object 
' **Description: This function will return HomeViewController
'************
function HomeViewController() as object
    if m._homeViewControllerSingleton = invalid
        
        prototype = BaseController()


        '************
        '- Function Name:  ``init``
        '- Param: parent as object
        '************
        prototype.init = sub(parent as object,payload as object)
            homeView = createObject("roSGNode","HomeView")
            
            homeView.observeField("selectedMenuIndex","onSelectMenu")
            homeView.observeField("selectedShowIndex","onSelectShow")

            parent.appendChild(homeView)
            
            m.setup(homeView)
            m.setModel(HomeViewModel())
            'Initialize observer            
            m._model.init()
        end sub

        prototype.selectedMenuIndex = sub(index as integer)
            m._model.setSelectedMenu(index)
            m._topRef.shows = m._model.getShowsForSelectedMenu()
        end sub

        prototype.onSelectShow = sub(index as integer)
            show = m._topRef.shows.getChild(index)
            scene = m._topRef.getScene()
            scene.callfunc("navigateTo",getScreens().SHOW_DETAIL,show)
        end sub

        '************
        '- Function Name:  ``onReceivedShows`` 
        ' **Description: This function will trigger when shows received from API
        '************
        prototype.onReceivedShows = sub()
            m._topRef.menuItems = m._model.getMenuItems()
            m._topRef.shows = m._model.getShowsForSelectedMenu()
        end sub

        m._homeViewControllerSingleton = prototype
    end if
    return m._homeViewControllerSingleton
end function

'=========================================
'# {Start}:Home View observerfield function handler 
'========================================
 sub onSelectMenu(event as object)
    index = event.getData()
    if m._homeViewControllerSingleton <> invalid
        m._homeViewControllerSingleton.selectedMenuIndex(index)
    end if
 end sub

 sub onSelectShow(event as object)
    index = event.getData()
    if m._homeViewControllerSingleton <> invalid
        m._homeViewControllerSingleton.onSelectShow(index)
    end if
 end sub
'=========================================
'# {End}:Home View observerfield function handler 
'========================================
