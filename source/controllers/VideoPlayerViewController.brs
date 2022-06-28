'************
'- Function Name:  ``VideoPlayerViewController``
'- Return: return type as object 
' **Description: This function will return VideoPlayerViewController
'************
function VideoPlayerViewController() as object
    if m._videoPlayerViewControllerSingleton = invalid
        
        prototype = BaseController()


        '************
        '- Function Name:  ``init``
        '- Param: parent as object
        '************
        prototype.init = sub(parent as object,payload as object)
            videoPlayerView = createObject("roSGNode","VideoPlayerView")
            parent.appendChild(videoPlayerView)
            m.setup(videoPlayerView)

            m.setModel(VideoPlayerViewModel())   
            m._model.init()
            m.onContnetUpdate()
        end sub

        prototype.launch = sub()
            m._topRef.visible = true
        end sub

        prototype.onContnetUpdate = sub()
            m._topRef.videoContent = m._model.getContent()
        end sub

        m._videoPlayerViewControllerSingleton = prototype
    end if
    return m._videoPlayerViewControllerSingleton
end function