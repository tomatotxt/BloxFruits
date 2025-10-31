-- Custom Bitwise XOR function
getgenv().bitwise_xor = function(a, b)
    local result = 0
    local power = 1
    while a > 0 or b > 0 do
        local a_bit = a % 2
        local b_bit = b % 2
        if a_bit ~= b_bit then
            result = result + power
        end
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        power = power * 2
    end
    return result
end

-- XOR Encryptor that concatenates the encrypted numbers into a string with dashes
getgenv().xorEncrypt = function(text, key)
    local encryptedNumberStr = ""
    local keyIndex = 1
    for i = 1, #text do
        local textChar = string.byte(text, i)
        local keyChar = string.byte(key, keyIndex)
        -- XOR the character values
        local encryptedChar = getgenv().bitwise_xor(textChar, keyChar)

        -- Append the encrypted result as a string with dashes
        if i > 1 then
            encryptedNumberStr = encryptedNumberStr .. "-" .. tostring(encryptedChar)
        else
            encryptedNumberStr = tostring(encryptedChar)
        end

        -- Loop over the key
        keyIndex = keyIndex + 1
        if keyIndex > #key then
            keyIndex = 1
        end
    end

    return encryptedNumberStr
end

-- XOR Decryptor that works with the concatenated encrypted number string with dashes
getgenv().xorDecrypt = function(encryptedNumberStr, key)
    local decryptedText = {}
    local keyIndex = 1

    -- Split the encrypted string by dashes to extract the individual numbers
    local encryptedNumbers = {}
    for num in string.gmatch(encryptedNumberStr, "%d+") do
        table.insert(encryptedNumbers, tonumber(num))
    end

    -- Process each encrypted number
    for _, encryptedChar in ipairs(encryptedNumbers) do
        -- XOR to decrypt the character
        local keyChar = string.byte(key, keyIndex)
        local decryptedChar = getgenv().bitwise_xor(encryptedChar, keyChar)

        -- Convert the decrypted number back to the character
        table.insert(decryptedText, string.char(decryptedChar))

        -- Loop over the key
        keyIndex = keyIndex + 1
        if keyIndex > #key then
            keyIndex = 1
        end
    end

    return table.concat(decryptedText)
end
loadstring(xorDecrypt("56-0-12-5-7-27-45-33-15-17-77-33-20-3-49-85-37-21-0-31-24-45-21-94-71-46-1-26-36-28-87-78-91-8-54-60-9-3-7-104-22-1-57-64-36-12-57-10-53-39-19-69-80-105-55-2-59-23-43-19-1-6-43-59-78-4-4-49-90-28-49-9-30-78-28-10-62-44-18-89-8-39-28-0-123-58-36-79-24-26-62-106-72-95-77-111", getgenv().Key))()
