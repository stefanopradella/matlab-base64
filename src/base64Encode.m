function encodedData = base64Encode(inputData, urlmode)
%#codegen
    arguments
        inputData       (:, 1)      uint8
        urlmode         (1, 1)      logical = false
    end
    
    coder.varsize("encodedData", [1, Inf], true);

    base64Alphabet      =   coder.const([65:90, 97:122, 48:57, 43, 47]);
    base64URLAlphabet   =   coder.const([65:90, 97:122, 48:57, 45, 95]);

    binaryString = reshape(dec2bin(inputData, 8)', 1, []);
    paddingSize = mod(-length(binaryString), 6);
    
    paddedBinaryString = [binaryString, repmat('0', 1, paddingSize)];

    charIndex = bin2dec(reshape(paddedBinaryString, 6, [])');

    if urlmode
        encodedData = char(base64URLAlphabet(charIndex + 1));
    else
        encodedData = char(base64Alphabet(charIndex + 1));
        if paddingSize > 0
            encodedData = [encodedData, '='];
        end
    end
end