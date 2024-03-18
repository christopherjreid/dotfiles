
return {
--  settings = {
    cmd = {"clangd", "--background-index", "-j=4", "--completion-style=detailed", "--compile-commands-dir=./build/", "--clang-tidy"},
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
--  }
}
