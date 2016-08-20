function pps#vimrc#configure(activate) abort
    let activate = a:activate

    if activate
        let vimrc = b:pps_project_dir . '/vimrc'

        if !filereadable(vimrc)
            let activate = 0
        endif
    endif

    if activate
        execute 'source' vimrc
    endif
endfunction

