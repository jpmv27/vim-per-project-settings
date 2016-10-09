command! -nargs=? PpsMkdir call pps#utils#make_dir(<f-args>)

command! -nargs=? -complete=custom,pps#utils#dir_complete PpsRmdir call pps#utils#remove_dir(<f-args>)

command! -nargs=? -complete=custom,pps#utils#file_complete PpsEdit call pps#utils#edit_file(<f-args>)

command! -nargs=1 -complete=custom,pps#utils#file_complete PpsDelete call pps#utils#remove_file(<f-args>)

command! -nargs=0 PpsVimrc call pps#vimrc#edit()

command! -nargs=0 PpsEgApply call pps#easygrep#apply()

command! -nargs=0 PpsEgReset call pps#easygrep#restore_defaults()

