function fish_user_key_bindings
  # fzf
  bind \cf _fzf_search_directory

  # vim-like
  #bind \cl forward-char

  # prevent iterm2 from closing when typing Ctrl-D (EOF)
  bind \cd delete-char
end

# fzf plugin
fzf_configure_bindings --directory=\co
