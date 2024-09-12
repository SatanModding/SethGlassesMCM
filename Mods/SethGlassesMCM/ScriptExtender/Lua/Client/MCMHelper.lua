----------------------------------------------------------------------------------------
--
--                  IMGUI helper functions for creating IMGIO objects            
--
----------------------------------------------------------------------------------------



MCMHelper = {}
MCMHelper.__index = MCMHelper


-- Creates a separator, but white
---@param parent IMGUI object
---@param name string
function MCMHelper:CreateWhiteSeparator(parent, name)
    local separator = parent:AddSeparatorText(name)
    separator:SetColor(0, WHITE)
    
end


-- Creates a text, but white
---@param parent IMGUI object
---@param name string
function MCMHelper:CreateWhiteText(parent, name)
    local text = parent:AddText(name)
    text:SetColor(0,WHITE)
    
end


-- creates an empty (space) string of certain size 
---@param size integer 
---@return str string
function MCMHelper:EmptyText(size)
    return string.rep(" ", size)
end


-- creates a text in the same line. Don't call it for the first element
---@param parent IMGUI object
---@param name string
function MCMHelper:AddTextSameLine(parent,text)
    local textField = parent:AddText(text)
    textField.SameLine = true
    return textField
end


-- creates a text in the same line. Don't call it for the first element - but in white
---@param parent IMGUI object
---@param name string
function MCMHelper:AddTextSameLineWhite(parent,text)
    local textField = parent:AddText(text)
    textField:SetColor(0,WHITE)
    textField.SameLine = true
    return textField
end



-- Creates a table of images with descriptions underneath
-- row 1 : image
-- row 2: text
---@param parent IMGUI
---@param images table sorted table of valid image names (point to an atlas)
---@param descriptions table - sorted table of strings
---@param imageSize vec2 -- size of image
---@param tableSize vec2 -- size of table
---@param id string -- unique identifier for the table
function MCMHelper:CreateTableOfImageAndDescription(parent, images, descriptions, imageSize, tableSize, id)

    local buttons = {}
    local myTable = parent:AddTable(id,#images)
   -- myTable.Borders = true --This can be enabled for development
    myTable.Size = tableSize
    local imageRow = myTable:AddRow()
    local descRow = myTable:AddRow()

    for i, image in pairs(images) do

        local imageLabel = image
        local style = SatanDoesIMGUI:GetStyle(image)
        local type = SatanDoesIMGUI:GetType(images[1])

        if style == "NONE" then
            imageLabel = image .. type
        end


        local imgbtn = imageRow:AddCell():AddImageButton(imageLabel,image, imageSize) 
        table.insert(buttons, imgbtn)
        descRow:AddCell():AddText(descriptions[i])

    end

    return buttons, myTable

end



-- Creates a table of images with descriptions underneath
-- row 1 : image
-- row 2: text
---@param parent IMGUI
---@param images table sorted table of valid image names (point to an atlas)
---@param descriptions table - sorted table of strings
---@param size vec2 -- size ofimage
---@param id string -- unique identifier for the table
---@---@param type enum - [PRESET, FRAME, ETC]
function MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, images, descriptions, imageSize, tableSize, id)
    local buttons = {}
    local myTable = parent:AddTable(id,#images)
   -- myTable.Borders = true --This can be enabled for development
    myTable.SameLine = true
    myTable.Size = tableSize
    local imageRow = myTable:AddRow()
    local descRow = myTable:AddRow()

    for i, image in pairs(images) do
    
        local imageLabel = image
        local style = SatanDoesIMGUI:GetStyle(image)
        local type = SatanDoesIMGUI:GetType(images[1])
        
        if style == "NONE" then
            imageLabel = image .. type
        end

        local imgbtn = imageRow:AddCell():AddImageButton(imageLabel,image, imageSize) 
        table.insert(buttons, imgbtn)
        descRow:AddCell():AddText(descriptions[i])
    end
    return buttons, myTable
end
