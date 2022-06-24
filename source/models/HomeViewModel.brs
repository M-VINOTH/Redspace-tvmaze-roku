'************
'- Function Name:  ``HomeViewModel`` 
'- Return:  return as obejct
' **Description: This function will return the homeView Model object
'************
function HomeViewModel() as object
    if m._homeViewModelSingleton  = invalid
        prototype = {}

        m._homeViewModelSingleton = prototype
    end if

    return m._homeViewModelSingleton
end function
