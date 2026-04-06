inputTypes = cell(1, 1);
inputTypes{1} = coder.newtype("uint8", [Inf 1]);
inputTypes{2} = coder.newtype("logical", [1 1]);

codegen -config getCoderConfig() -report -o matlab_base64 base64Encode.m -args inputTypes base64Decode.m -args inputTypes