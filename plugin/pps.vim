command! -nargs=0 PpsUpdateTags call pps#tags#update()

command! -nargs=0 PpsEraseTags call pps#tags#erase()

command! -nargs=0 PpsMkdir call pps#utils#make_project_dir()

command! -nargs=0 PpsRmdir call pps#utils#remove_project_dir()

command! -nargs=0 PpsVimrc call pps#vimrc#edit()

