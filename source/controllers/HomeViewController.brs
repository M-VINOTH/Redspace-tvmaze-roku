'************
'- Function Name:  ``HomeViewController``
'- Return: return type as object 
' **Description: This function will return HomeViewController
'************
function HomeViewController() as object
    if m_homeViewControllerSingleton = invalid
        
        prototype = BaseController()

        '************
        '- Function Name:  ``init``
        '- Params: 
        '- Return:  
        ' **Description: 
        '************
        prototype.init = sub()
            homeView = createObject("roSGNode","HomeView")
            m.setModel(HomeViewModel())
        end sub

        prototype = m._homeViewControllerSingleton
    end if
end function
