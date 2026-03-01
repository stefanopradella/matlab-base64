classdef FunctionalTests < matlab.unittest.TestCase

    properties
        nRandomisedTestIterations = 1000;
        maxBytesRandomisedTest = 1024;
    end

    methods (Test)

        function randomisedEncoding(testCase)

            for iIteration = 1:testCase.nRandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesRandomisedTest])));
                result = base64Encode(inputData, false);
                expectedValue = matlab.net.base64encode(inputData);

                testCase.verifyEqual(result, expectedValue);
            end
        end

        function randomisedDecoding(testCase)
            
            for iIteration = 1:testCase.nRandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesRandomisedTest])));
                encodedData = matlab.net.base64encode(inputData);

                result = base64Decode(encodedData, false);
                expectedValue = matlab.net.base64decode(encodedData);

                testCase.verifyEqual(result, expectedValue);
            end
        end
        
        function randomisedEncodingURLMode(testCase)

            for iIteration = 1:testCase.nRandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesRandomisedTest])));
                result = base64Encode(inputData, true);
                expectedValue = matlab.net.base64encode(inputData);
                expectedValue = strrep(expectedValue, '+', '-');
                expectedValue = strrep(expectedValue, '/', '_');
                expectedValue = strrep(expectedValue, '=', '');

                testCase.verifyEqual(result, expectedValue);
            end
        end

       function randomisedDecodingURLMode(testCase)
            
            for iIteration = 1:testCase.nRandomisedTestIterations
                inputData = uint8(randi([0 2^8-1], 1, randi([1 testCase.maxBytesRandomisedTest])));
                encodedData = matlab.net.base64encode(inputData);

                encodedDataURLMode = encodedData;
                encodedDataURLMode = strrep(encodedDataURLMode, '+', '-');
                encodedDataURLMode = strrep(encodedDataURLMode, '/', '_');
                encodedDataURLMode = strrep(encodedDataURLMode, '=', '');

                result = base64Decode(encodedDataURLMode, true);
                expectedValue = matlab.net.base64decode(encodedData);

                testCase.verifyEqual(result, expectedValue);
            end
        end
    end

end