'************
'- Function Name:  ``ShowDetailViewModel``
'- Return:  return as object
' **Description: This function will return the Show Detail Model object
'************
function ShowDetailViewModel() as object
    if m._showDetailViewModelSingleton = invalid
        prototype = {}

        ' Private property
        prototype._show = invalid
        prototype._episodes = invalid
        prototype._seasonWiseEpisodes = invalid
        prototype._selectedSeasonIndex = 0
        
        '=========================================
        '# {Start}:Public Functions 
        '========================================
        prototype.init = sub(show as object)
          m.setShow(show)
          getShowEpisode(show.id)
        end sub

        '=========================================
        '# {End}:Public Functions 
        '========================================
        
        '=========================================
        '# {Start}:Setter || getter methods
        '========================================
        prototype.setShow = function(show as object)as boolean
            m._show = show
            return true
        end function

        prototype.getShow = function() as object
            return m._show
        end function

        prototype.setEpisodes = function(episodes as object)as boolean
            m._episodes = episodes
            return true
        end function

        prototype.getEpisodes = function() as object
            return m._episodes
        end function

        prototype.setSeasonWiseEpisodes = function(seasonWiseEpisodes as object)as boolean
            m._seasonWiseEpisodes = seasonWiseEpisodes
            return true
        end function

        prototype.getSeasonWiseEpisodes = function() as object
            return m._seasonWiseEpisodes
        end function

        prototype.setSelectedSeasonIndex = function(index as integer)as boolean
            m._selectedSeasonIndex = index
            return true
        end function

        prototype.getEpisodesForSelectedSeason = function() as dynamic
            seasons = m._seasonWiseEpisodes.keys()
            episodes = m._seasonWiseEpisodes[seasons[m._selectedSeasonIndex]]
            episodeContentNode = createObject("roSGNode", "ContentNode")
            for each episode in episodes
                episodeNode = episodeContentNode.createChild("EpisodeContentNode")
                episodeNode.title = episode.name
                episodeNode.posterURL = episode.image.original
                episodeNode.seasonNumber = episode.season
                episodeNode.episodeNumber = episode.number
                episodeNode.id = episode.id
            end for

            return episodeContentNode
        end function

        prototype.getSeasonNumber = function() as dynamic
            seasons = m._seasonWiseEpisodes.keys()
            seasonsContentNode = createObject("roSGNode", "ContentNode")
            for each season in seasons
                seasonNode = seasonsContentNode.createChild("MenuContentNode")
                seasonNode.title = "S"+ season
            end for

            return seasonsContentNode
        end function

        
        '=========================================
        '# {End}:Setter || getter methods
        '========================================


        '=========================================
        '# {Start}:API Response Handler function
        '========================================
        prototype.onReceivedEpisodes = sub(response as object)
            m.setEpisodes(response)
            m.setSeasonWiseEpisodes(filterArrWithKey(response,"season"))
        end sub
        '=========================================
        '# {End}:API Response Handler function
        '========================================

        m._showDetailViewModelSingleton = prototype
    end if

    return m._showDetailViewModelSingleton
end function

'=========================================
'# {Start}:Handle API Functions
'========================================
'************
'- Function Name:  ``getShow``
'- Return: retunr as object
' **Description: This function will trigger a Task node to get Shows from API
'************
sub getShowEpisode(showID as string)

    createTaskPromise("ContentServiceTask", { runFunction: "getEpisodes",data:{showID:showID} }, true, "response").then(sub(response as object)
        if response.status = 200
            if m._showDetailViewModelSingleton <> invalid
                m._showDetailViewModelSingleton.onReceivedEpisodes(response.body.json)
                m._showDetailViewControllerSingleton.onReceivedEpisodes()
            end if
        end if

    end sub)
end sub

'=========================================
'# {End}:Handle API Functions
'========================================
