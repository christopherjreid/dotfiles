require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  sh = {
    icon = "",
    color = "#428850",
    name = "Sh"
  },
  lua = {
      icon = "",
      color = "#00007C",
      name = "Lua"
 }};
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
