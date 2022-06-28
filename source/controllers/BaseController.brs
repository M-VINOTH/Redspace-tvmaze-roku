'************
'- Function Name:  ``BaseController``
'- Return:  return as object
'************
function BaseController() as object
    if m._baseControllerSingleton = invalid
        prototype = {}

        'Private properties
        m._topRef = invalid
        m._model = invalid
        
        '************
        '- Function Name:  ``init``
        '- Param: parent as object
        '************
        prototype.init = sub(parent as object,payload as object)
        end sub

        '************
        '- Function Name:  ``setup``
        '- Params:  node as object 
        '************
        prototype.setup = sub(top as object)
            m._topRef = top
        end sub

        '************
        '- Function Name:  ``setup``
        '- Params:  model as object 
        '************
        prototype.setModel = sub(model as object)
            m._model = model
        end sub

        '************
        '- Function Name:  ``launch``
        '************
        prototype.launch = sub()
            m._topRef.visible = true
        end sub

        '************
        '- Function Name:  ``setFocus``
        '************
        prototype.setFocus = sub()
            m._topRef.setFocus(true)
        end sub
       
        '************
        '- Function Name:  ``destory``
        '************
        prototype.destroy = sub()
            scene = m._topRef.getScene()
            m._topRef.visible = false
            scene.removeChild(m._topRef)
            m._topRef = invalid
        end sub

        m._baseControllerSingleton = prototype
    end if
    return m._baseControllerSingleton
end function
