classdef FunctionalTests < matlab.unittest.TestCase

    properties
        nrandomisedTestIterations = 1000;
        maxBytesrandomisedTest = 1024;
    end

    methods (Test)

        function randomisedEncoding(testCase)

            for iIteration = 1:testCase.nrandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesrandomisedTest])));
                result = base64Encode(inputData, false);
                expectedValue = matlab.net.base64encode(inputData);

                testCase.verifyEqual(result, expectedValue);
            end
        end

        function randomisedDecoding(testCase)
            
            for iIteration = 1:testCase.nrandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesrandomisedTest])));
                encodedData = matlab.net.base64encode(inputData);

                result = base64Decode(encodedData, false);
                expectedValue = matlab.net.base64decode(encodedData);

                testCase.verifyEqual(result, expectedValue);
            end
        end
        
        
    end

end