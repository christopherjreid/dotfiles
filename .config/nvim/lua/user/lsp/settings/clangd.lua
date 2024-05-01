
return {
--  settings = {
    cmd = {"clangd", "--log=error", "--background-index", "-j=4", "--completion-style=detailed", "--compile-commands-dir=./build/", "--clang-tidy", "--enable-config"},
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
--  }
}
