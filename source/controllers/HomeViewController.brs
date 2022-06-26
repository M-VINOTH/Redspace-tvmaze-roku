'************
'- Function Name:  ``HomeViewController``
'- Return: return type as object 
' **Description: This function will return HomeViewController
'************
function HomeViewController() as object
    if m._homeViewControllerSingleton = invalid
        
        prototype = BaseController()

        '************
        '- Function Name:  ``init``
        '- Param: parent as object
        '************
        prototype.init = sub(parent as object)
            homeView = createObject("roSGNode","HomeView")
            parent.appendChild(homeView)
            
            m.setup(homeView)
            m.setModel(HomeViewModel())
            
            'Initialize observer            
            
            m._model.init()
            homeView.menuItems = m._model.getMenuItems()
        end sub

        m._homeViewControllerSingleton = prototype
    end if
    return m._homeViewControllerSingleton
end function

'=========================================
'# {Start}:Home View observerfield function handler 
'========================================
 
'=========================================
'# {End}:Home View observerfield function handler 
'========================================
