inputTypes = cell(1, 1);
inputTypes{1} = coder.newtype("uint8", [Inf 1]);
inputTypes{2} = coder.newtype("logical", [1 1]);


codegen -config getCoderConfig() -report base64Encode.m -args inputTypes

codegen -config getCoderConfig() -report base64Decode.m -args inputTypes