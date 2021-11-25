command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
command! NvimSettings silent! execute "vsp $MYVIMRC"
command! BspwmSettings silent! execute "vsp ~/.config/bspwm/bspwmrc"
command! PolybarSettings silent! execute "vsp ~/.config/polybar/config"
command! SxhkdSettings silent! execute "vsp ~/.config/sxhkd/sxhkdrc"
command! AlacrittySettings silent! execute "vsp ~/.config/alacritty/alacritty.yml"
command! PicomSettings silent! execute "vsp ~/.config/picom/picom.conf"
command! DwmSxhkdSettings silent! execute "vsp ~/.config/sxhkd.dwm/sxhkdrc"
command! PluginsNvim silent! execute "vsp $HOME/.config/nvim/plugins/plugins.vim"
command! GoSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/go.vim"
command! PhpSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/php.vim"
command! CppSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/cpp.vim"
command! JavascriptSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/javascript.vim"
command! ReloadNvim silent! execute "so $MYVIMRC" | echo "Nvim reloded"
command! -nargs=1 JumpToTag call JumpToTag(<f-args>, ['f', 'function', 'c', 'class', 'i', 'interface', 't', 'trait', 'm'])
command! FocusOnFile silent! NvimTreeFindFile
command! DeleteCurrentFile call delete(expand('%')) | bdelete!
command! SudoSave :execute 'silent w !sudo tee % > /dev/null' | :edit!
