'************
'- Function Name:  ``HomeViewModel`` 
'- Return:  return as obejct
' **Description: This function will return the homeView Model object
'************
function HomeViewModel() as object
    if m._homeViewModelSingleton  = invalid
        prototype = {}


        prototype.init = sub()

        end sub

        prototype.getMenuItems = function() as object
            menuContentNode = createObject("roSGNode","ContentNode")

            for index = 0 to 5
                menu = menuContentNode.createChild("MenuContentNode")
                menu.title = "test"
            end for
            return menuContentNode
        end function
        
        
        m._homeViewModelSingleton = prototype
    end if

    return m._homeViewModelSingleton
end function
