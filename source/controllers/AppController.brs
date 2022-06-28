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

            if  m._screenStack.peek() <> invalid
                lastState = m._screenStack.peek()
                lastState.visible = false
            end if

            if screens.HOME_VIEW = screenName
                currentState = CreateObject("roSGNode","HomeView") 
            else if screens.SHOW_DETAIL = screenName
                currentState = CreateObject("roSGNode","ShowDetail") 
            else if screens.VIDEO_VIEW = screenName
                currentState = CreateObject("roSGNode","VideoPlayerView") 
            end if
            currentState.payload = {data: payload}
            m._screenStack.push(currentState)

        end sub

        prototype.navigateBack = sub()
            if m._screenStack.count() > 1
                lastState = m._screenStack.pop()
                lastState.visible = false
                m._root.removeChild(lastState)

                currentState = m._screenStack.peek()
                currentState.visible = true
                currentState.setFocus(true)
            end if
        end sub
        m._appControllerSingleton = prototype
    end if
    return m._appControllerSingleton
end function
