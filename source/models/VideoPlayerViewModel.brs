'************
'- Function Name:  ``VideoPlayerViewModel``
'- Return:  return as obejct
' **Description: This function will return the VideoPlayerView Model object
'************
function VideoPlayerViewModel() as object
    if m._videoPlayerViewModelSingleton = invalid
        prototype = {}

        ' Private property
        prototype._content = invalid
        
        '=========================================
        '# {Start}:Public Functions 
        '========================================
        prototype.init = sub()
            videoContent = prepareVideoContent()
            m.setContent(videoContent)
        end sub

        '=========================================
        '# {End}:Public Functions 
        '========================================
        
        '=========================================
        '# {Start}:Setter || getter methods
        '========================================
        prototype.setContent = function(content as object)as boolean
            m._content = content
            return true
        end function

        prototype.getContent = function() as object
            return m._content
        end function

        '=========================================
        '# {End}:Setter || getter methods
        '========================================


        m._videoPlayerViewModelSingleton = prototype
    end if

    return m._videoPlayerViewModelSingleton
end function


'************
'- Function Name:  ``prepareVideoContent``
'************
function prepareVideoContent()as object
    videoContent = CreateObject("roSGNode","ContentNode")
    videoContent.title = "Red Space TestVideo"
    videoContent.url = "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
    videoContent.streamformat = "hls"
    return videoContent
end function
