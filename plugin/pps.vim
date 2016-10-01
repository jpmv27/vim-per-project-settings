command! -nargs=0 PpsMkdir call pps#utils#make_project_dir()

command! -nargs=0 PpsRmdir call pps#utils#remove_project_dir()

command! -nargs=0 PpsVimrc call pps#vimrc#edit()

command! -nargs=0 PpsEgEdit call pps#easygrep#edit()

command! -nargs=0 PpsEgApply call pps#easygrep#apply()

command! -nargs=0 PpsEgReset call pps#easygrep#restore_defaults()

function! PpsDir() abort
    return pps#utils#get_project_dir()
endfunction

