function getFont(fontType as string, size as integer)as object

    fonts = {
        bold: "pkg:/resources/fonts/ProximaNova-Bold.otf"
        light: "pkg:/resources/fonts/ProximaNova-Light.otf"
        regular: "pkg:/resources/fonts/ProximaNova-Regular.otf"
        semiBold: "pkg:/resources/fonts/ProximaNova-Semibold.otf"
    }

    font = CreateObject("roSGNode","Font")
    font.uri = fonts[fontType]
    font.size = size
    return font
end function