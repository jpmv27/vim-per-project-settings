command! -nargs=0 PpsUpdateTags call pps#tags#update()

command! -nargs=0 PpsRemoveTags call pps#tags#remove()

command! -nargs=0 PpsMkdir call pps#utils#make_project_dir()

command! -nargs=0 PpsVimrc call pps#vimrc#edit()

