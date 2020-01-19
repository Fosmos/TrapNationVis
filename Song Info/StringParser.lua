function Initialize()
end

local function split(word, delimiter, close)
    local result = {};
    for istr in string.gmatch(word, "([^ ]+)") do
        table.insert(result, istr)
    end

    local newWord = ""
    local flag = false
    for i, v in ipairs(result) do
        if (v == delimiter) then
            flag = true
        end
        if(flag == false) then
            newWord = newWord.." "..v
        end
        if(string.sub(v, -1) == close) then
            flag = false
        end
    end

    return newWord

end

local function splitOnWord(word, delimiter)
    local result = {};
    for istr in string.gmatch(word, "([^ ]+)") do
        table.insert(result, istr)
    end

    local newWord = ""
    for i, v in ipairs(result) do
        if (v == delimiter) then
            break
        end
        newWord = newWord.." "..v
    end

    return newWord
end

function Update()
    Artist = SKIN:GetMeasure('MeasureArtist')
    Track = SKIN:GetMeasure('MeasureTrack')

    ArtistName = Artist:GetStringValue()
    TrackName = Track:GetStringValue()

    ArtistName = splitOnWord(ArtistName, 'Feat.')
    TrackName = split(TrackName, '(feat.', ')')

    SKIN:Bang('!SetOption', 'MeterArtist', 'Text', ArtistName)
    SKIN:Bang('!SetOption', 'MeterTrack', 'Text', TrackName)
end

