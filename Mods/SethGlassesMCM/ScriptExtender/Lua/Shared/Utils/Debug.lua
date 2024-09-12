GLOBALDEBUG = false


function SatanPrint(debug, message)

    local modname = "[SETH_GLASSES_MCM] "

    if debug then
        _P(modname .. message)
    end
end



function SatanDump(debug, message)

    if debug then
        _D(message)
    end
end