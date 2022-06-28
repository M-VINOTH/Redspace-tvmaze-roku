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
        prototype.init = sub(node as object,parent as object,payload as object)
            showDetail = node

            showDetail.observeField("selectedSeasonIndex","onSelectSeasonIndex")
            showDetail.observeField("selectedEpisodeIndex","onSelectEpisodeIndex")

            parent.appendChild(showDetail)
            
            m.setup(showDetail)
            m.setModel(ShowDetailViewModel())

            'Initialize observer            
            m._model.init(payload.data)
        end sub

        prototype.onSelectSeasonIndex = sub(index as integer)
            m._model.setSelectedSeasonIndex(index)
            m._topRef.episodes = m._model.getEpisodesForSelectedSeason()
        end sub


        prototype.onSelectEpisodeIndex = sub(index as integer)
            scene = m._topRef.getScene()
            isDRM = index MOD 2 ' Event epsisode will play the DRM content
            scene.callfunc("navigateTo",getScreens().VIDEO_VIEW,isDRM)
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

'=========================================
'# {Start}:Show Detail View observerfield function handler 
'========================================
sub onSelectSeasonIndex(event as object)
    index = event.getData()
    if m._showDetailViewControllerSingleton <> invalid
        m._showDetailViewControllerSingleton.onSelectSeasonIndex(index)
    end if
 end sub

 sub onSelectEpisodeIndex(event as object)
    index = event.getData()
    if m._showDetailViewControllerSingleton <> invalid
        m._showDetailViewControllerSingleton.onSelectEpisodeIndex(index)
    end if
 end sub
'=========================================
'# {End}:Home View observerfield function handler 
'========================================