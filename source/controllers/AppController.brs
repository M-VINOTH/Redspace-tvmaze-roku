'************
'- Function Name:  ``AppController``
'- Return:  return as object
'************
function AppController() as object
    if m._appControllerSingleton = invalid
        prototype = {}

        'private properties
        prototype._root = invalid

        prototype._screenStack = []
        prototype._currentState = invalid
        '************
        '- Function Name:  ``init``
        '- Params:  rootNode as object 
        '************
        prototype.init = sub(rootNode as object)
            m._root = rootNode
        end sub

        '************
        '- Function Name:  ``navigate``
        '- Params:  screenName as string 
        '- Params:  payload as dynamic 
        '************
        prototype.navigate = sub(screenName as string, payload as dynamic)
            screens  = getScreens()
            currentState = invalid
            if screens.HOME_VIEW = screenName
                currentState = HomeViewController()
            else if screens.SHOW_DETAIL = screenName
                currentState = ShowDetailViewController()
            else if screens.VIDEO_VIEW = screenName
                currentState = VideoPlayerViewController()
            end if
            m._screenStack.push(currentState)
            currentState.init(m._root,payload)
            currentState.launch()
            currentState.setFocus()
        end sub

        prototype.navigateBack = sub()
            if m._screenStack.count() > 1
                currentState = m._screenStack.pop()
                currentState.launch()
                currentState.setFocus()
            end if
        end sub
        m._appControllerSingleton = prototype
    end if
    return m._appControllerSingleton
end function
