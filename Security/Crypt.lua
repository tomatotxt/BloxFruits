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
