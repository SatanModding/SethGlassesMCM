MCMHelper = {}
MCMHelper.__index = MCMHelper


---@param parent IMGUI object
---@param name string
function MCMHelper:CreateWhiteSeparator(parent, name)
    local separator = parent:AddSeparatorText(name)
    separator:SetColor(0, WHITE)
    
end


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
end


-- creates a text in the same line. Don't call it for the first element - but in white
---@param parent IMGUI object
---@param name string
function MCMHelper:AddTextSameLineWhite(parent,text)
    local textField = parent:AddText(text)
    textField:SetColor(0,WHITE)
    textField.SameLine = true
end

---@param parent IMGUI
---@param images table sorted table of valid image names (point to an atlas)
---@param descriptions table - sorted table of strings
---@param imageSize vec2 -- size of image
---@param tableSize vec2 -- size of table
---@param id string -- unique identifier for the table
function MCMHelper:CreateTableOfImageAndDescription(parent, images, descriptions, imageSize, tableSize, id)
    local myTable = parent:AddTable(id,#images)
   -- myTable.Borders = true
    myTable.Size = tableSize
    local imageRow = myTable:AddRow()
    local descRow = myTable:AddRow()

    for i, image in pairs(images) do
        local imgbtn = imageRow:AddCell():AddImageButton(image,image, imageSize) 
        descRow:AddCell():AddText(descriptions[i])
        imgbtn.OnClick = function()
            _P("[DEBUG SETH_GLASSES] ", imgbtn.Image.Icon) -- use this to get the UUID
            _P("[DEBUG SETH_GLASSES] parent: ", myTable.ParentElement.Label)
        end
    end
end



-- TODO - tables don't seem to like sameLine
---@param parent IMGUI
---@param images table sorted table of valid image names (point to an atlas)
---@param descriptions table - sorted table of strings
---@param size vec2 -- size ofimage
---@param id string -- unique identifier for the table
function MCMHelper:CreateTableOfImageAndDescriptionSameLine(parent, images, descriptions, imageSize, tableSize, id)
    local myTable = parent:AddTable(id,#images)
   -- myTable.Borders = true
    myTable.SameLine = true
    myTable.Size = tableSize
    local imageRow = myTable:AddRow()
    local descRow = myTable:AddRow()

    for i, image in pairs(images) do
        local imgbtn = imageRow:AddCell():AddImageButton(image,image, imageSize) 
        descRow:AddCell():AddText(descriptions[i])
        imgbtn.OnClick = function()
            _P("[DEBUG SETH_GLASSES] ", imgbtn.Image.Icon) -- use this to get the UUID
            _P("[DEBUG SETH_GLASSES] parent: ", myTable.ParentElement.Label)
        end
    end
end
