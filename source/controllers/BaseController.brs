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
        '************
        prototype.init = sub()
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
       
        m._baseControllerSingleton = prototype
    end if
    return m._baseControllerSingleton
end function
