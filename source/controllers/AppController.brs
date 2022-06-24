'************
'- Function Name:  ``AppController``
'- Return:  return as object
'************
function AppController() as object
    if m._appControllerSingleton = invalid
        prototype = {}

        'private properties
        prototype._root = invalid

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
            if screens.HOME_VIEW = screenName
                
            else if screens.VIDEO_VIEW = screenName

            end if
        end sub
        m._appControllerSingleton = prototype
    end if
    return m._appControllerSingleton
end function
