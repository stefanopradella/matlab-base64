classdef EquivalenceTest < matlabtest.coder.TestCase

    properties
        nRandomisedTestIterations = 1000;
        maxBytesRandomisedTest = 1024;
    end

    methods (Test)
        function equivalenceTest(testCase)

            inputTypes = cell(1, 1);
            inputTypes{1} = coder.newtype("uint8", [Inf 1]);
            inputTypes{2} = coder.newtype("logical", [1 1]);

            buildResults = build(testCase,"base64Encode",Inputs=inputTypes, Configuration=getCoderConfig());

            for iIteration = 1:testCase.nRandomisedTestIterations
                inputVector = uint8(randi([0 2^8-1], randi([1 testCase.maxBytesRandomisedTest]), 1));

                executionResults = execute(testCase,buildResults, Inputs={inputVector, true});
                verifyExecutionMatchesMATLAB(testCase,executionResults)
            end
        end
    end

end