function! s:vimrc_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    return dir . '/vimrc'
endfunction

function! pps#vimrc#configure(active) abort
    let active = a:active

    if active
        let vimrc = s:vimrc_file_path()

        if (vimrc ==# '') || !filereadable(vimrc)
            let active = 0
        endif
    endif

    if active
        execute 'source' vimrc
    endif
endfunction

function! pps#vimrc#edit() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'You must create the project directory first'
        return
    endif

    let vimrc = s:vimrc_file_path()
    if vimrc ==# ''
        return
    endif

    execute 'split ' . vimrc
endfunction

