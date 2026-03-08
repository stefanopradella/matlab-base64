function cfg = getCoderConfig()
    cfg = coder.config("lib", "ecoder", true);
    cfg.DataTypeReplacement = "CBuiltIn";
    cfg.SaturateOnIntegerOverflow = false;
    cfg.SupportNonFinite = false;
end