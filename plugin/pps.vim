command! -nargs=0 UpdateTags call pps#tags#update()

command! -nargs=0 PpsMkdir call pps#utils#make_project_dir()

command! -nargs=0 PpsVimrc call pps#vimrc#edit()

