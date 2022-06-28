'************
'- Function Name:  ``ShowDetailViewController``
'- Return: return type as object 
' **Description: This function will return ShowDetailViewController
'************
function ShowDetailViewController() as object
    if m._showDetailViewControllerSingleton = invalid
        
        prototype = BaseController()

        '************
        '- Function Name:  ``init``
        '- Param: parent as object
        '************
        prototype.init = sub(parent as object,payload as object)
            showDetail = createObject("roSGNode","ShowDetail")
            
            parent.appendChild(showDetail)
            
            m.setup(showDetail)
            m.setModel(ShowDetailViewModel())

            'Initialize observer            
            m._model.init(payload)
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
        '- Function Name:  ``onReceivedEpisodes`` 
        ' **Description: This function will trigger when shows received from API
        '************
        prototype.onReceivedEpisodes = sub()
            m._topRef.show = m._model.getShow()
            m._topRef.episodes = m._model.getEpisodesForSelectedSeason()
            m._topRef.seasonNumberMenu = m._model.getSeasonNumber()
        end sub

        m._showDetailViewControllerSingleton = prototype
    end if
    return m._showDetailViewControllerSingleton
end function
