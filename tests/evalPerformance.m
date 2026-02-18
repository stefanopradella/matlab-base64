nIterations         =   10000;
maxTestVectorSize   =   1024;


%% Encoder

disp("===== ENCODER =====")

% Generate input
inputData_encoder = cell(nIterations, 1);
for iTestVector = 1:nIterations
    inputData_encoder{iTestVector} = uint8(randi([0 2^8-1], 1, randi([1 maxTestVectorSize])));
end

tic;
for iIteration = 1:nIterations
    tmp = matlab.net.base64encode(inputData_encoder{iIteration});
end
executionTime = toc;

fprintf("matlab.net.base64encode execution time: %3.2f s\n", executionTime);

tic;
for iIteration = 1:nIterations
    tmp = base64Encode(inputData_encoder{iIteration}, false);
end
executionTime = toc;

fprintf("base64Encode execution time: %3.2f s\n", executionTime);


%% Decoder

disp("===== DECODER =====")

% Generate input
inputData_encoder = cell(nIterations, 1);
for iTestVector = 1:nIterations
    inputData_decoder{iTestVector} = matlab.net.base64encode(uint8(randi([0 2^8-1], 1, randi([1 maxTestVectorSize]))));
end

tic;
for iIteration = 1:nIterations
    tmp = matlab.net.base64decode(inputData_decoder{iIteration});
end
executionTime = toc;

fprintf("matlab.net.base64decode execution time: %3.2f s\n", executionTime);

tic;
for iIteration = 1:nIterations
    tmp = base64Decode(inputData_decoder{iIteration}, false);
end
executionTime = toc;

fprintf("base64Decode execution time: %3.2f s\n", executionTime);