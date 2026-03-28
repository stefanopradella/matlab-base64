function encodedData = base64Encode(inputData, urlmode)
%#codegen
    arguments
        inputData       (1, :)      uint8
        urlmode         (1, 1)      logical = false
    end

    % Make the variable persistent for efficiency.
    % At each function call check urlmode and eventually change the table
    % calling the function. The condition check is odd because persistent 
    % variables must be populated before using them in the cindition of an
    % if statemens.
    persistent base64AlphabetTable;
    persistent lastURLmode;
    if isempty(lastURLmode)
        lastURLmode = urlmode;
    end
    if isempty(base64AlphabetTable)
        base64AlphabetTable = getBase64AlphabetTable(urlmode);
    end
    if urlmode ~= lastURLmode
        base64AlphabetTable = getBase64AlphabetTable(urlmode);
        lastURLmode = urlmode;
    end
    
    inputSize = numel(inputData);

    paddingLength = mod(3 - mod(inputSize, 3), 3);

    nBlocks = ceil(inputSize / 3);

    inputData = [inputData, uint8(zeros(1, paddingLength))];
    inputData = reshape(inputData', 3, nBlocks);
    

    inputBytes = uint8(zeros(4, nBlocks));
    inputBytes(1, :) = bitshift(inputData(1, :), -2);
    inputBytes(2, :) = bitor(bitshift(bitand(inputData(1, :), uint8(3)), 4), bitshift(inputData(2, :), -4));
    inputBytes(3, :) = bitor(bitshift(bitand(inputData(2, :), uint8(15)), 2), bitshift(inputData(3, :), -6));
    inputBytes(4, :) = bitand(inputData(3, :), uint8(63));

    encodedData = base64AlphabetTable(inputBytes(:) + 1);

    if paddingLength > 0
        if urlmode
            encodedData = encodedData(1:end-paddingLength);
        else
            encodedData(end-paddingLength+1:end) = '=';
        end
    end
end

function getBase64AlphabetTable = getBase64AlphabetTable(urlmode)

    getBase64AlphabetTable = char(zeros(1, 64));

    % Standard Base64
    getBase64AlphabetTable(1:26)    =   uint8('A':'Z');
    getBase64AlphabetTable(27:52)   =   uint8('a':'z');
    getBase64AlphabetTable(53:62)   =   uint8('0':'9');

    if urlmode
        %Base64URL characters
        getBase64AlphabetTable(63)  =   uint8('-');
        getBase64AlphabetTable(64)  =   uint8('_');
    else
        getBase64AlphabetTable(63)  =   uint8('+');
        getBase64AlphabetTable(64)  =   uint8('/');
    end
end