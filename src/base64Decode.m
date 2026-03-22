function decodedData = base64Decode(inputData, urlmode)
%#codegen
    arguments
        inputData       (1, :)      char
        urlmode         (1, 1)      logical = false
    end
    
    coder.varsize("decodedData", [1, Inf], [false true]);

    % Make the variable persistend and map to const for efficiency
    persistent base64DecodeTable;
    if isempty(base64DecodeTable)
        base64DecodeTable = coder.const(getBase64DecodeTable());
    end

    inputSize = numel(inputData);
    nBlocks = ceil(inputSize / 4);

    if urlmode
        paddingLength = mod(4 - mod(inputSize, 4), 4);
        inputData = [inputData, repelem('=', 1, paddingLength)];
    else
        paddingLength = sum(inputData(end-1:end) == '=');
    end

    decodedBytes = base64DecodeTable(inputData);

    decodedBytes = reshape(decodedBytes, 4, nBlocks); % 4 rows, N columns

    % Vectorized shift-or
    decodedData = uint8(zeros(3, nBlocks));
    decodedData(1, :) = bitor(bitshift(decodedBytes(1, :), 2), bitshift(decodedBytes(2, :), -4));
    decodedData(2, :) = bitor(bitshift(decodedBytes(2, :), 4), bitshift(decodedBytes(3, :), -2));
    decodedData(3, :) = bitor(bitshift(decodedBytes(3, :), 6), decodedBytes(4, :));

    decodedData = decodedData(:)';

    % Remove padding
    decodedData = decodedData(1:end-paddingLength);
    
end

function base64DecodeTable = getBase64DecodeTable()

    base64DecodeTable = uint8(zeros(1, 122));

    % Standard Base64
    base64DecodeTable(uint8('A':'Z'))   =   0:25;
    base64DecodeTable(uint8('a':'z'))   =   26:51;
    base64DecodeTable(uint8('0':'9'))   =   52:61;
    base64DecodeTable(uint8('+'))       =   62;
    base64DecodeTable(uint8('/'))       =   63;

    %Base64URL characters
    base64DecodeTable(uint8('-'))       =   62;
    base64DecodeTable(uint8('_'))       =   63;
end