function decodedData = base64Decode(inputData, urlmode)
%#codegen
    arguments
        inputData       (1, :)      char
        urlmode         (1, 1)      logical = false
    end
    
    coder.varsize("decodedData", [1, Inf], true);

    base64DecodeTable      =   coder.const(uint8([zeros(1, 42), 63, zeros(1, 3), 64, 53:62, zeros(1, 7), 1:26, zeros(1, 6), 27:52]) - 1);
    
    
    if urlmode

    else
        inputSize = size(inputData, 2);

        decodedData = uint8(zeros(1, inputSize*3/4));

        decodedBytes = base64DecodeTable(inputData);

        for iBlock = 0:(inputSize/4)-1
            startIdx_dec = iBlock*3;
            startIdx_enc = iBlock*4;
            decodedData(startIdx_dec + 1) = bitor(bitshift(decodedBytes(startIdx_enc + 1), 2), bitshift(decodedBytes(startIdx_enc + 2), -4));
            decodedData(startIdx_dec + 2) = bitor(bitshift(decodedBytes(startIdx_enc + 2), 4), bitshift(decodedBytes(startIdx_enc + 3), -2));
            decodedData(startIdx_dec + 3) = bitor(bitshift(decodedBytes(startIdx_enc + 3), 6), decodedBytes(startIdx_enc + 4));
        end

        % Remove padding
        if inputData(end) == '='
            if inputData(end-1) == '='
                decodedData = decodedData(1:end-2);
            else
                decodedData = decodedData(1:end-1);
            end
        end
    end
end