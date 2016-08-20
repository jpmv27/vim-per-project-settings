function pps#vimrc#apply() abort
    let vimrc = b:pps_project_dir . '/vimrc'
    if filereadable(vimrc)
        execute 'source' vimrc
    endif
endfunction

